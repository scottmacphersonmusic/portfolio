class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user
    @article = article
  end

  def publish?
    user && user.editor? ? true : false
  end

  def create?
    user && (user.editor? || user.author?) ? true : false
  end

  def update?
    if user
      return true if user.editor? || (user.id == article.author_id &&
                                      article.published == false)
    else
      false
    end
  end

  def destroy?
    user && user.editor?
  end

  class Scope < Scope
    def resolve
      if user && user.editor?
        scope.all
      elsif user && user.author?
        scope.where(author_id: user.id)
      else
        scope.where(published: true)
      end
    end
  end
end
