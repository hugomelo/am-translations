class Paragraph < ActiveRecord::Base
  belongs_to :project
  attr_accessible :chapter, :status, :text, :order
end
