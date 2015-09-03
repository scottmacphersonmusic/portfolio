# coding: utf-8
require "test_helper"

feature "Deleting An Article" do
  scenario "article is deleted with click" do
    # Given that there is an existing article
    Article.create(title: "Rails For Dummies",
                   body: "Dummies can't do Rails.")
    visit articles_path
    # When I click destroy
    page.click_on "Destroy"
    # Then the article is destroyed
    page.must_have_content "Article was successfully destroyed."
    page.wont_have_content "Rails For Dummies"
  end
end
