class Reviewer < ActiveRecord::Base
  belongs_to :reviewer
  belongs_to :project
  # attr_accessible :title, :body
end
