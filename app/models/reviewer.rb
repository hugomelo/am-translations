class Reviewer < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_and_belongs_to_many :chapters
  attr_accessible :project_id, :user_id
end
