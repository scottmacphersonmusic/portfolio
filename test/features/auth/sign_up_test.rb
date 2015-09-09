require "test_helper"

feature "As a site owner, I want to be able to sign up for an account,
so that I can access features restricted to those who are signed in" do
  scenario "sign up" do
    # Given a signup form
    visit "/"
    click_on "Sign Up"
    # When I submit valid info
    fill_in "Email", with: "scomo@example.com"
    fill_in "Password", with: "password"
    fill_in "Confirm Password", with: "password"
    click_on "Sign Up"
    # Then I should be signed up
    page.must_have_content "Sign up successful!"
  end
end
