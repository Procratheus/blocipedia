class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  validates_presence_of :user, :wiki
  validates_uniqueness_of :user, :scope => :wiki

end