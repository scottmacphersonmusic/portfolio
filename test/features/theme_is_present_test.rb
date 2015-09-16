require "test_helper"

feature "Theme/Template Is Present" do
  scenario "zurb css classes are present" do
    visit root_path
    classes = %w(nav.top-bar ul.title-area div.hero div.row div.columns)
    classes.each { |c| page.must_have_css(c) }
  end

  scenario "the expected javascript files are present" do
    visit root_path
    page.html.must_include "modernizr"
  end
end
