require "test_helper"

feature "Visiting the Article Index" do
  scenario "with articles" do
    # Given that there are existing articles
    Article.create(title: "Conundrum",
                   body: "The following sentence is true:\n" \
                         "The preceding sentence is false.")
    # When I visit '/articles'
    visit articles_path
    # The articles should be loaded
    page.text.must_include "Conundrum"
  end
end
