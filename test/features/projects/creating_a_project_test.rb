require "test_helper"

feature "As the site owner, I want to add a portfolio item so that I can show
 off my work" do
  scenario "adding a new project" do
    visit projects_path
    click_on "New Project"
    fill_in "Name", with: "Super Cool App"
    fill_in "Technologies Used", with: "Rails, Ruby, Foundation, HTML5, CSS3"
    click_on "Create Project"
    page.text.must_include "Project has been created"
    assert page.has_css?("#notice"), "Expected a flash notice - none found"
    page.status_code.must_equal 200
  end
end
