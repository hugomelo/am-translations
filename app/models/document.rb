class Document < ActiveRecord::Base
  belongs_to :language
  has_one :source_project, :class_name => 'Project', :foreign_key => :source_id
  has_one :translated_project, :class_name => 'Project', :foreign_key => :document_id
  attr_accessible :filename, :name
end
