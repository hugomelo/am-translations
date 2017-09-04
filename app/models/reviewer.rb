class Reviewer < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_and_belongs_to_many :chapters

  def name
    self.user.blank? ? '' : self.user.name
  end

  def email
    self.user.blank? ? '' : self.user.email
  end
end
