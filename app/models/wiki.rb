class Wiki < ActiveRecord::Base
  has_many :users, through: :collaborators
  has_many :collaborators, dependent: :destroy

  scope :publicly_viewable, -> { where(private: nil) }
  scope :privately_viewable, -> (user) { where(private: true, user_id: user.id) }
end
