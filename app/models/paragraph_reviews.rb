class ParagraphReviews < ActiveRecord::Base
  belongs_to :review
  belongs_to :paragraph
  # attr_accessible :title, :body
end
