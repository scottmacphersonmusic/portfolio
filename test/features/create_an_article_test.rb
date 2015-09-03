require "test_helper"

feature "Create An Article" do
  scenario "submit form data to create a new article" do
    # Given that there is a new article page
    visit new_article_path
    # When I submit the form
    fill_in 'Title', :with => "My Favorite Things"
    fill_in 'Body', :with => "Raindrops on roses..."
    click_on 'Create Article'
    # Then a new article should be created and displayed
    page.text.must_include "My Favorite Things"
  end
end
