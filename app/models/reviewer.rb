class Reviewer < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_and_belongs_to_many :chapters
  attr_accessible :project_id, :user_id, :chapter_ids

  def name
    self.user.blank? ? '' : self.user.name
  end

  def email
    self.user.blank? ? '' : self.user.email
  end
end
