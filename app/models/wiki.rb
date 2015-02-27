class Wiki < ActiveRecord::Base
  belongs_to :user

  scope :visible_to, -> (user) { user.role == "premium" ? publicly_viewable && privately_viewable : publicly_viewable }
  scope :publicly_viewable, -> { where(private: nil)}
  scope :privately_viewable, -> { where(private: true, user_id: current.id)}
end
