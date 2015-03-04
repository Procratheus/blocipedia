class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki
  has_many :shared_wikis

end