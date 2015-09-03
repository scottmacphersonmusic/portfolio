require "test_helper"

feature "Editing An Article" do
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
end
