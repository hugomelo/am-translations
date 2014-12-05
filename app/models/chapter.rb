class Chapter < ActiveRecord::Base
  attr_accessible :document_id, :name, :order

  has_many :paragraphs
  belongs_to :document
end
