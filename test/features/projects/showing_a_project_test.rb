require "test_helper"

feature "As a visitor, I want to be able to view a single project" do
  scenario "show project" do
    # Given a project exists
    # When I visit its show page
    visit project_path(projects(:hack))
    # Then it displays its info
    page.must_have_content "Hacktastic"
  end
end
