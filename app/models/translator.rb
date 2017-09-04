# encoding: utf-8
class Translator < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_and_belongs_to_many :chapters
  validates_presence_of :project_id, :user_id

  def name
    self.user.blank? ? '' : self.user.name
  end

  def email
    self.user.blank? ? '' : self.user.email
  end
end
