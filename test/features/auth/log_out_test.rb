require "test_helper"

feature "As the site owner, I want to sign out a user to prevent fraud" do
  scenario "log out" do
    # Given a user is signed in
    visit "/"
    click_on "Sign Up"
    fill_in "Email", with: "lionelmessi@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Sign Up"
    # When they click log out
    click_on "Log Out"
    # Then they will be logged out
    page.must_have_content "Signed out successfully."
  end
end
