class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article
  def initialize(user, article)
    @user = user
    @article = article
  end

  class Scope < Scope
    def resolve
      scope
    end
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

  def publish?
    user && user.editor? ? true : false
  end
end
