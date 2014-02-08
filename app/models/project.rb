class Project < ActiveRecord::Base
  belongs_to :source, :class_name => 'Document'
  belongs_to :document
  belongs_to :owner, :class_name => 'User'
  attr_accessible :name
end
