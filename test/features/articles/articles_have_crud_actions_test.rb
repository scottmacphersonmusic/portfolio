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
    article = articles(:rails)
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
    # Given an authorized user visits an article show page
    sign_in
    visit article_path(articles(:rails))
    # When I click destroy
    click_link('article_destroy')
    # Then the article is destroyed
    page.must_have_content "Article was successfully destroyed."
    page.wont_have_content "Its the Rails way or the highway"
  end
end
