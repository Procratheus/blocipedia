class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :publicly_viewable, -> { where(private: nil) }
  scope :privately_viewable, -> (user) { where(private: true, user_id: user.id) }
end
