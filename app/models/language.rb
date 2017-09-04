class Language < ApplicationRecord

  def name_abbrev
  	  "#{self.name} (#{self.abbreviation})"
  end
end
