require "test_helper"

feature "As a site owner, I want to be able to sign up for an account,
so that I can access features restricted to those who are signed in" do
  scenario "sign up" do
    # Given a signup form, When I submit valid info
    signup
    # Then I should be signed up
    page.must_have_content "Welcome! You have signed up successfully."
  end
end
