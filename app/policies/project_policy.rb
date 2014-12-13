class ProjectPolicy < ApplicationPolicy
  def assign_translators?
      true
  end
  def assign_reviewers?
      true
  end
  def assign_chapters?
      true
  end

  def create?
    user.admin?
  end

  def update?
    record.owner == user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
