require "test_helper"

feature "Uses Zurb Framework" do
  scenario "zurb is referenced in markup" do
    visit articles_path
    page.html.must_include "modernizr.js"
  end
end
