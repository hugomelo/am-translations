class Review < ApplicationRecord
  belongs_to :reviewer
  belongs_to :document
  attr_accessible :general_comment
end
