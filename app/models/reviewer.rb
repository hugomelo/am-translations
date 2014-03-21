class Reviewer < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :reviews
  # attr_accessible :title, :body
end
