require "test_helper"

feature "As a site visitor, I want to see a porfolio overview" do
  scenario "index displays all projects" do
    # Given some projects exist
    # When I visit /projects
    visit projects_path
    # Then I should see a list of projects
    page.text.must_include "Hacktastic"
    page.text.must_include "Zoo App"
  end
end
