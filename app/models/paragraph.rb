class Paragraph < ActiveRecord::Base
  belongs_to :project
  attr_accessible :project_id, :chapter, :status, :text, :order
end
