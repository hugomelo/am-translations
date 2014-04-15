class Document < ActiveRecord::Base
  has_one :from_project, class_name: :project, foreign_key: :from_document_id
  has_many :to_project, class_name: :project, foreign_key: :to_document_id
  belongs_to :to_language, :class_name => 'Language'
  belongs_to :from_language, :class_name => 'Language'
  has_many :paragraphs
end
