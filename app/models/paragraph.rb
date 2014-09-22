class Paragraph < ActiveRecord::Base
  belongs_to :document
  attr_accessible :document_id, :chapter, :status, :text, :order

  scope :in_chapter, lambda {|chapter| where(:chapter => chapter)}
end
