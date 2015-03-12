class Wiki < ActiveRecord::Base
  before_save :wiki_default
  has_many :collaborators, dependent: :destroy
  belongs_to :user
  has_many :shared_users, through: :collaborators, source: :user
  
  scope :publicly_viewable, -> (user){ user.role == "public" ? where(private: false) : where(private: false) }
  scope :privately_viewable, -> (user) { user.role == "admin" ? where(private: true) : where(private: true, user_id: user.id) }

  def wiki_default
    if user.role == "public"
      self.private = "false"
    end
  end

end
