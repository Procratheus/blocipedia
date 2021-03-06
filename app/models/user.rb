class User < ActiveRecord::Base
  after_initialize :set_default_user

  TEMP_EMAIL_PREFIX = "change@me"
  TEMP_EMAIL_REGEX = /\Achange@me/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:twitter, :facebook]
 
  # Setup Friendly_id
  #extend FriendlyId 
  #friendly_id :name, use: :slugged
  
  # Model Associations
  has_many :identities, dependent: :destroy
  has_many :collaborators, dependent: :destroy
  has_many :wikis, dependent: :destroy
  has_many :shared_wikis, through: :collaborators, source: :wiki 

  # Validations
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  # Omniauth Setup
  def self.find_for_oauth(auth, signed_in_resource = nil)
    
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user
    
    if user.nil?
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(email: email).first if email

      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
          )
      user.skip_confirmation!
      user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  # Establish User Roles

  def set_default_user
    self.role = "public" if self.role.nil?  
  end

  def public?
    self.update(role: "public")
    self.wikis.each do |x|
      x.update(private: nil)
    end
  end

  def premium? 
    self.update(role: "premium")
  end

  def admin?
    self.update(role: "admin")
  end

end
