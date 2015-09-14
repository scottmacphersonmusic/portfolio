require "simplecov"
require "coveralls"

SimpleCov.formatter = Coveralls::SimpleCov::Formatter
SimpleCov.start 'rails'

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara"
require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def sign_up
    visit "/"
    click_on "Sign Up"
    fill_in "Email", with: "donald@trump.sad"
    fill_in "Password", with: "thedonald"
    fill_in "Password confirmation", with: "thedonald"
    click_on "Sign Up"
  end

  def sign_in(role = :editor)
    visit new_user_session_path
    fill_in :Email, with: users(role).email
    fill_in :Password, with: "password"
    click_on "Log in"
  end
end
