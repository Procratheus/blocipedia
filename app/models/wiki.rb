class Wiki < ActiveRecord::Base
  has_many :collaborators
  has_many :users, through: :collaborators
  
  scope :publicly_viewable, -> { where(private: nil) }
  scope :privately_viewable, -> (user) { user.role == "admin" ? where(private: true) : where(private: true, user_id: user.id) }

  def add_user_id_to_wiki(user)
    self.user_id = user.id
  end

end
