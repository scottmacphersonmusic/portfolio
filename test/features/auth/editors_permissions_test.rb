require "test_helper"

feature "Editors have complete access to the site" do
  before do
    sign_in
  end

  scenario "editors can publish" do
    # Given an editor's account
    # When I visit the new page
    visit new_article_path
    # There is a checkbox for 'Published'
    page.must_have_field('Published')
    # When I submit the form
    fill_in "Title", with: articles(:one).title
    fill_in "Body", with: articles(:one).body
    check "Published"
    click_on "Create Article"
    # Then the published article should be shown
    page.text.must_include "Status: Published"
  end

  scenario "editors can see all articles published or not" do
    # Given an editor's account
    # When I visit the article index page
    visit articles_path
    # Then I see all posts whether they are published or not
    page.must_have_content "Conundrum"
    page.must_have_content "Unpublished Article"
  end

  scenario "editor can create articles" do
    # Given an editor's account
    # When I fill out and submit a new article
    visit new_article_path
    fill_in "Title", with: "Messi vs Ronaldo"
    fill_in "Body", with: "there is no competition"
    click_on "Create Article"
    # It gets created
    page.must_have_content "Article was successfully created."
    page.must_have_content "Messi vs Ronaldo"
  end

  scenario "editors can edit articles" do
    # Given an editor's account
    # When I edit an article and submit
    article = articles(:published)
    visit edit_article_path(article)
    fill_in "Title", with: "Edited Article"
    click_on "Update Article"
    # Then the article is edited
    page.must_have_content "Article was successfully updated."
    page.must_have_content "Edited Article"
  end

  scenario "editors can delete articles" do
    # Given an editor's account
    # When I go to an article page and click destroy
    article = articles(:published)
    visit article_path(article)
    click_on "Destroy"
    # It gets deleted
    page.must_have_content "Article was successfully destroyed"
    page.wont_have_content "Conundrum"
  end
end
