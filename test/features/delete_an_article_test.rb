# coding: utf-8
require "test_helper"

feature "Deleting An Article" do
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
