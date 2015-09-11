require "test_helper"

feature "As the site owner, I want to sign out a user to prevent fraud" do
  scenario "log out" do
    # Given a user is signed in
    signup
    # When they click log out
    click_on "Log Out"
    # Then they will be logged out
    page.must_have_content "Signed out successfully."
  end
end
