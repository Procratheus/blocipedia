class Wiki < ActiveRecord::Base
  has_many :collaborators, dependent: :destroy
  belongs_to :user
  has_many :shared_users, through: :collaborators, source: :user
  
  scope :publicly_viewable, -> { where.not(private: true) }
  scope :privately_viewable, -> (user) { user.role == "admin" ? where(private: true) : where(private: true, user_id: user.id) }

  def self.viewable_collaborations(user) 
    @user = user
    wikis = [] 
    self.all.each do |wiki|
      coll_wiki = wiki.collaborators.where(user_id: @user.id) 
      wiki_coll = Wiki.find_by(id: coll_wiki.wiki_id)
      wikis << wiki_coll
    end
    wikis
  end

end
