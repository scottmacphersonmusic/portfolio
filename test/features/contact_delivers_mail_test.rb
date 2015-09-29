require "test_helper"

feature "Email the user notifications" do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  scenario "authors receive an email when their article are published" do
    sign_in
    # Given an unpublished article
    visit edit_article_path articles(:unpublished)
    # When the article is published
    check "Published"
    click_on "Update Article"
    # Then the author should be notified by email
    email.must reply_to("scottmacphersonmusic@gmail.com")
    email.must deliver_to "author@example.com"
    email.must have_subject "Article Published"
    email.must have_body_text "your article has been published"
  end
end
