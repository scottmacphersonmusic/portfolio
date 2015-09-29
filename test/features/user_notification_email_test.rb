require "test_helper"

feature "Email the user notifications" do
  scenario "authors receive an email when their article is published" do
    sign_in
    # Given an unpublished article
    visit edit_article_path articles(:unpublished)
    # When the article is published
    check "Published"
    click_on "Update Article"
    # email = UserNotificationMailer.article_published(articles(:unpublished))
    # Then the author should be notified by email
    puts ActionMailer::Base.deliveries.last.to.first
  end
end
