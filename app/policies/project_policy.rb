class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

	def initialize(user, project)
		@user = user
		@project = project
	end
  def assign_translators?
    project.owner == user
  end
  def assign_reviewers?
    project.owner == user
  end
  def assign_chapters?
    project.owner == user
  end
  def translate?
    user.translation_projects.include? project or project.owner == user
  end
  def review?
    user.review_projects.include? project or project.owner == user
  end

  def create?
    project.owner == user
  end

  def update?
    project.owner == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
