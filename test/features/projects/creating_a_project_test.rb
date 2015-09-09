require "test_helper"

feature "As the site owner, I want to add a portfolio item so that I can show
 off my work" do
  scenario "adding a new project" do
    visit projects_path
    click_on "New Project"
    fill_in "Name", with: "Super Cool App"
    fill_in "Technologies used", with: "Rails, Ruby, Foundation, HTML5, CSS3"
    click_on "Create Project"
    page.text.must_include "Project successfully created!"
    assert page.has_css?(".notice"), "Expected a flash notice - none found"
    page.status_code.must_equal 200
  end

  scenario "adding an invalid project fails" do
    # Given invalid project data is entered in a form
    visit new_project_path
    fill_in "Name", with: "S"
    # When the form is submitted with a short name and missing technologies_used field
    click_on "Create Project"
    # Then the form should be displayed again, with an error message
    current_path.must_match(/projects$/)
    page.text.must_include "There was a problem saving your project!"
    page.text.must_include "Name is too short"
    page.text.must_include "Technologies used can't be blank"
  end
end
