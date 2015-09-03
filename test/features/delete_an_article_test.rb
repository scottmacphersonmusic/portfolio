# coding: utf-8
require "test_helper"

feature "Deleting An Article" do
  require "capybara/poltergeist"
  # include Capybara::DSL
  Capybara.register_driver :poltergeist do |config|
    Capybara::Poltergeist::Driver.new(config, timeout: 1000)
  end
  # Capybara::Webkit.configure do |config|
  #   config.debug = true
  #   config.timeout = 5
  # end
  Capybara.javascript_driver = :poltergeist

  scenario "article is deleted with click", js: true do
    # Given that there is an existing article
    Article.create(title: "Rails For Dummies",
                   body: "Dummies can't do Rails.")
    visit articles_path
    # When I click destroy
    accept_confirm do
      page.find("tbody tr:last").click_on "Destroy"
    end
    # Then the article is destroyed
    page.wont_have_content "Rails For Dummies"
  end
end
