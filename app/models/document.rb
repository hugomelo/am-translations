class Document < ActiveRecord::Base
  belongs_to :language
  attr_accessible :filename, :name
end
