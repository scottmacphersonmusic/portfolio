require "test_helper"

feature "Options for using the site vary based on user role" do
  scenario "unauthenticated site visitors cannot visit new_article_path" do
    visit new_article_path
    page.must_have_content "You need to sign in or sign up before continuing"
  end

  scenario "unauthenticated users cannot see new article button" do
    # When I visit the blog index page as a visitor
    visit articles_path
    # Then I should not see the "New Article" button
    page.wont_have_link "New Article"
  end

  scenario "authors can't publish" do
    # Given an author's account
    sign_in(:author)
    # When I visit the new page
    visit new_article_path
    # There is no checkbox for 'published'
    page.wont_have_field('published')
  end

  scenario "editors can publish" do
    # Given an editor's account
    sign_in(:editor)
    # When I visit the new page
    visit new_article_path
    # There is a checkbox for 'Published'
    page.must_have_field('Published')
    # When I submit the form
    fill_in "Title",  with: articles(:one).title
    fill_in "Body", with: articles(:one).body
    check "Published"
    click_on "Create Article"
    # Then the published article should be shown
    page.text.must_include "Status: Published"
  end
end
