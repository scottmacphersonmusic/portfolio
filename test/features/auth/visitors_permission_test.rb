require 'test_helper'

feature "unathenticated visitors have limited access" do
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

  scenario "unauthenticated users can view published articles" do
    # When I click show on an article
    visit articles_path
    page.find('tbody tr:last').click_on "Show"
    # Then I can view that article's show page
    page.must_have_content "Its the Rails way or the highway"
  end

  scenario "visitors cant edit or delete articles" do
    # When I visit the article index page
    visit articles_path
    # Then I don't have any options to edit or delete
    page.wont_have_link "Edit"
    page.wont_have_link "Destroy"
    # And the show page doesn't either
    page.find('tbody tr:last').click_on "Show"
    page.wont_have_link "Edit"
    page.wont_have_link "Destroy"
  end

  scenario "visitors only see published articles" do
    # When I visit the article index page
    visit articles_path
    # Then I can only see published articles
    page.must_have_content "Conundrum"
    page.wont_have_content "Unpublished Article"
  end
end
