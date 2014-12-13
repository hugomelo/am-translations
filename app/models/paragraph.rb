class Paragraph < ActiveRecord::Base
  belongs_to :document
  attr_accessible :document_id, :chapter_id, :status, :text, :order

  scope :in_chapter, lambda {|chapter_id| where(:chapter_id => chapter_id)}
end
