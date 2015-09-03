require "test_helper"

feature "Deleting An Article" do
  scenario "article is deleted with click" do
    # Given that there is an existing article
    Article.create(title: "Rails For Dummies",
                   body: "Dummies can't do Rails.")
    visit articles_path
    # When I click destroy
    click 'Destroy'
    handle_js_confirm
    # Then the article is destroyed
    page.text.wont_include "Rails For Dummies"
  end
end
