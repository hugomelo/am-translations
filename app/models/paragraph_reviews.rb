class ParagraphReviews < ApplicationRecord
  belongs_to :review
  belongs_to :paragraph
  # attr_accessible :title, :body
end
