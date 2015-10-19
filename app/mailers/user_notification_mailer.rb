class UserNotificationMailer < ApplicationMailer
  default from: "scottmacphersonmusic@gmail.com"

  def article_published(article)
    @article = article
    @user = article.author
    mail to: @user.email,
         subject: "Article Published"
  end
end
