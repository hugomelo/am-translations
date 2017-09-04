class Paragraph < ApplicationRecord
  belongs_to :document

  default_scope ->{ order(:order) }
  scope :in_chapter, lambda {|chapter_id| where(:chapter_id => chapter_id)}

end
