require "test_helper"

feature "As the site owner, I want to edit a portfolio item so that I can update new project details" do
  scenario "editing a valid project" do
    # Given an existing project
    visit edit_project_path(projects(:hack))
    # When I submit changes
    fill_in "Name", with: "Extra Snazzy Project"
    click_on "Update Project"
    # Then the changes should be saved and shown
    page.text.must_include "Project successfully updated!"
    page.text.must_include "Extra Snazzy Project"
    page.text.wont_include "Hacktastic"
  end

  scenario "incorrectly editing an existing project" do
    # Given an existing project
    visit edit_project_path(projects(:hack))
    # When I submit invalid changes
    fill_in "Name", with: ""
    click_on "Update Project"
    # Then the changes should not be saved, and I should get to try again
    page.text.must_include "prohibited"
    page.text.must_include "Name is too short"
  end
end
