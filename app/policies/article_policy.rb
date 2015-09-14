class ArticlePolicy < ApplicationPolicy
  attr_reader :user, :article

  def initialize(user, article)
    @user = user || NullUser.new
    @article = article
  end

  def publish?
    user.editor?
  end

  def create?
    user.editor? || user.author?
  end

  def update?
    user.editor? || (user.id == article.author_id &&
                     article.published == false)
  end

  def destroy?
    user.editor?
  end

  class Scope < Scope
    def resolve
      if user.editor?
        scope.all
      elsif user.author?
        scope.where(author_id: user.id)
      else
        scope.where(published: true)
      end
    end
  end
end

# class NullUser
#   def editor?
#     false
#   end
# end   - put this in the user class, initialize policy with `user || NullUser.new`
#       - needs to cover all the methods that are called on user and return false
#       - get rid of all the additional `user &&...` checks
