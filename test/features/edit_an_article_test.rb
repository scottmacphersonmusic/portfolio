require "test_helper"

feature "Editing An Article" do
  scenario "submit form data to edit an existing article" do
    # Given that there is an existing article
    article = Article.create(title: "Regarding Excellence",
                             body: "Be excellent.")
    visit article_path(article)
    click 'Edit'
    # When I edit and submit the form
    fill_in 'title', :with => "Regarding Mediocrity"
    fill_in 'body', :with => "meh..."
    click 'Update Article'
    # Then the article should be edited and displayed
    page.text.must_include "Regarding Mediocrity"
  end
end
