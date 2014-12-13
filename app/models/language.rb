class Language < ActiveRecord::Base
  attr_accessible :abbreviation, :name

  belongs_to :chapter

  def name_abbrev
  	  "#{self.name} (#{self.abbreviation})"
  end
end
