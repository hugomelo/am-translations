class Project < ActiveRecord::Base
  belongs_to :source
  belongs_to :document
  belongs_to :user
  attr_accessible :name
end
