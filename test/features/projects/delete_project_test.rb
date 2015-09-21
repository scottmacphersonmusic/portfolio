require "test_helper"

feature "As the site owner, I want to delete a portfolio item so that I can keep the list focused on my best work" do
  scenario "delete project" do
    # Given that a project exists
    visit project_path(projects(:zoo))
    # When I click destroy on the last project
    click_on "Destroy"
    # Then the project is destroyed
    page.must_have_content "Project was successfully destroyed!"
    page.wont_have_content "Zoo App"
    current_path.must_equal projects_path
  end
end
