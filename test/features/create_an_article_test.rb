require "test_helper"

feature "Create An Article" do
  scenario "submit form data to create a new article" do
    # Given that there is a new article page
    visit new_articles_path
    fill_in 'title', :with => "My Favorite Things"
    fill_in 'body', :with => "Raindrops on roses..."
    click 'submit'
    page.text.must_include "My Favorite Things"
  end
end
