require "test_helper"

feature "Articles Have Crud Actions" do
  scenario "create a new article" do
    # Given that there is a new article page
    visit new_article_path
    # When I submit the form
    fill_in 'Title', with: "My Favorite Things"
    fill_in 'Body', with: "Raindrops on roses..."
    click_on 'Create Article'
    # Then a new article should be created and displayed
    page.text.must_include "Article was successfully created"
    page.text.must_include "My Favorite Things"
    page.has_css? "#author"
    page.text.must_include users(:scott).email
  end

  scenario "submit form data to edit an existing article" do
    # Given that there is an existing article
    article = articles(:one)
    visit article_path(article)
    # When I edit and submit the form
    click_on 'Edit'
    fill_in 'Title', with: "Regarding Mediocrity"
    fill_in 'Body', with: "meh..."
    click_on 'Update Article'
    # Then the article should be edited and displayed
    page.text.must_include "Article was successfully updated"
    page.text.must_include "Regarding Mediocrity"
  end

  scenario "article is deleted with click" do
    # Given that there is an existing article
    visit articles_path
    # When I click destroy
    page.find('tbody tr:last').click_on "Destroy"
    # Then the article is destroyed
    page.must_have_content "Article was successfully destroyed."
    page.wont_have_content "or the highway"
  end
end
