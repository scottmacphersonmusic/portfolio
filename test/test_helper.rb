ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara"
require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def signup
    visit "/"
    click_on "Sign Up"
    fill_in "Email", with: "donald@trump.sad"
    fill_in "Password", with: "thedonald"
    fill_in "Password confirmation", with: "thedonald"
    click_on "Sign Up"
  end
end
