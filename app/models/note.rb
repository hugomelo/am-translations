class Note < ActiveRecord::Base
  belongs_to :paragraph
  belongs_to :translator
  attr_accessible :note
end
