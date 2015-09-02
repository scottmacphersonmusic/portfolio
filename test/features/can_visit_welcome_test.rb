require "test_helper"

class WelcomePageTest < Capybara::Rails::TestCase
  test "welcome page should exist" do
    visit root_path
    assert_content page, "Hello World"
    refute_content page, "Goobye All!"
  end
end
