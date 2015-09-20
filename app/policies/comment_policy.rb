class CommentPolicy < ApplicationPolicy
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def update?
    user && user.editor?
  end

  class Scope < Scope
    def resolve
      if user && user.editor?
        scope
      else
        scope.where(approved: true)
      end
    end
  end
end
