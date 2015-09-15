require "test_helper"

feature "Theme Is Present" do
  scenario "the expected stylesheets are present" do
    visit root_path
    save_and_open_page
    base = "/assets/"
    styles = %w(app foundation foundation_and_overrides scaffolds)
    styles.each { |s| page.html.must_have_content base + s }
  end

  scenario "the expected javascript files are present" do
    visit root_path
    base = "jquery.foundation."
    a = %w(accordion.js alerts.js buttons.js clearing.js forms.js joyride.js)
    b =  %w(magellan.js mediaQueryToggle.js navigation.js orbit.js reveal.js)
    c =  %w(tabs.js tooltips.js topbar.js)
    js = a + b + c
    js.each { |s| page.html.must_include base + s }
  end
end
