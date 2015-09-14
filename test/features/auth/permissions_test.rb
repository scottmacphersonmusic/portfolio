require "test_helper"

feature "Options for using the site vary based on user role" do

  # ----- Visitors -----
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

  # ----- Authors -----
  scenario "authors can create articles" do
    # Given an author's account
    sign_in(:author)
    # When I visit the new article page and submit
    visit articles_path
    click_on "New Article"
    fill_in "Title", with: "Food Trucks"
    fill_in "Body", with: "such tasty"
    click_on "Create Article"
    # Then a new article is created
    page.must_have_content "Article was successfully created."
    page.must_have_content "Food Trucks"
  end

  scenario "authors can only see their own articles" do
    # Given an author's account
    sign_in(:author)
    # When I visit the article index
    visit articles_path
    # Only my articles are shown
    page.must_have_content "Conundrum"
    page.must_have_content "Unpublished Article"
    page.wont_have_content "Rails"
  end

  scenario "authors can't publish" do
    # Given an author's account
    sign_in(:author)
    # When I visit the new page
    visit new_article_path
    # There is no checkbox for 'published'
    page.wont_have_field('published')
  end

  scenario "authors can update their own articles if unpublished" do
    # Given an author's account
    sign_in(:author)
    # When I visit the edit page
    article = articles(:unpublished)
    visit edit_article_path(article)
    # Then I am able to submit the form
    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "No more typos"
    click_on "Update Article"
    page.must_have_content "Updated Title"
    page.wont_have_content "This is an article full of typos."
  end

  scenario "authors cant update their own articles if published" do
    # Given an author's account
    sign_in(:author)
    # When I try to visit the edit page of my published article
    article = articles(:published)
    visit edit_article_path(article)
    # Then I am redirected and given a notice
    current_path.must_equal articles_path
    page.must_have_content "You are not authorized to perform this action."
  end

  scenario "authors cant delete articles" do
    # Given an author's account
    sign_in(:author)
    # When I visit an article page
    article = articles(:published)
    visit article_path(article)
    # Then there is no option to delete
    page.wont_have_link "Delete"
    # There also wont be delete links on the index view
    visit articles_path
    page.wont_have_link "Delete"
  end

  # ----- Editors -----
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

  scenario "editors can see all articles published or not" do
    # Given an editor's account
    sign_in(:editor)
    # When I visit the article index page
    visit articles_path
    # Then I see all posts whether they are published or not
    page.must_have_content "Conundrum"
    page.must_have_content "Unpublished Article"
  end

  scenario "editor can create articles" do
    # Given an editor's account
    sign_in(:editor)
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
    sign_in(:editor)
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
    sign_in(:editor)
    # When I go to an article page and click destroy
    article = articles(:published)
    visit article_path(article)
    click_on "Destroy"
    # It gets deleted
    page.must_have_content "Article was successfully destroyed"
    page.wont_have_content "Conundrum"
  end
end
