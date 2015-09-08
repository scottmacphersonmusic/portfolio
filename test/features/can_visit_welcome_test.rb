require "test_helper"

class WelcomePageTest < Capybara::Rails::TestCase
  test "welcome page should exist" do
    visit root_path
    assert_content page, "Scott Macpherson"
    refute_content page, "Goobye All!"
  end

  test "depoloyed app should have custom domain name" do
    visit "http://www.scottmacphersonmusic.com"
    assert_content page, "Web developer. Musician."
  end
end
