require "test_helper"

feature "Articles Have Crud Actions" do
  scenario "create a new article" do
    # Given an authorized user completes a new article form
    sign_in(:author)

    visit new_article_path
    # When I submit the form
    fill_in 'Title', with: "My Favorite Things"
    fill_in 'Body', with: "Raindrops on roses..."
    click_on 'Create Article'
    # Then a new article should be created and displayed
    page.text.must_include "Article was successfully created"
    page.text.must_include "My Favorite Things"
    page.has_css? "#author"
    page.text.must_include users(:author).email
    page.text.must_include "Status: Unpublished"
  end

  scenario "edit an existing article" do
    # Given an authorized user visits an articles edit page
    sign_in

    article = articles(:one)
    visit edit_article_path(article)
    # When I edit and submit the form
    fill_in 'Title', with: "Regarding Mediocrity"
    fill_in 'Body', with: "meh..."
    click_on 'Update Article'
    # Then the article should be edited and displayed
    page.text.must_include "Article was successfully updated"
    page.text.must_include "Regarding Mediocrity"
  end

  scenario "delete article" do
    # Given an authorized user visits the articles index page
    sign_in

    visit articles_path
    # When I click destroy
    page.find('tbody tr:last').click_on "Destroy"
    # Then the article is destroyed
    page.must_have_content "Article was successfully destroyed."
    page.wont_have_content "or the highway"
  end

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
