class Wiki < ActiveRecord::Base
  has_many :collaborators
  belongs_to :user
  has_many :shared_users, through: :collaborators, source: :user
  
  scope :publicly_viewable, -> { where(private: nil) }
  scope :privately_viewable, -> (user) { user.role == "admin" ? where(private: true) : where(private: true, user_id: user.id) }

  #def add_user_id_to_wiki(user)
    #self.user_id = user.id
  #end

end
