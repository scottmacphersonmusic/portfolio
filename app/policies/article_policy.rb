class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user && (user.editor? || user.author?) ? true : false
  end

  def publish?
    user && user.editor? ? true : false
  end
end
