# encoding: utf-8
class Translator < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_and_belongs_to_many :chapters
  attr_accessible :project_id, :user_id

  def name
    self.user.name
  end

  def email
    self.user.email
  end
end
