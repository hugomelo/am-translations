class Paragraph < ActiveRecord::Base
  belongs_to :document
  attr_accessible :chapter, :status, :text, :order
end
