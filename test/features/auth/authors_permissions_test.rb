require 'test_helper'

feature "authors have partial access to the site" do
  before do
    sign_in(:author)
  end
  scenario "authors can create articles" do
    # Given an author's account
    # When I visit the new article page and submit
    visit articles_path
    click_on "New Article"
    fill_in "Title", with: "Food Trucks"
    fill_in "Body", with: "such tasty"
    click_on "Create Article"
    # Then a new article is created
    page.must_have_content "Article was successfully created."
    page.must_have_content "Food Trucks"
  end

  scenario "authors can only see their own articles" do
    # Given an author's account
    # When I visit the article index
    visit articles_path
    # Only my articles are shown
    page.must_have_content "Conundrum"
    page.must_have_content "Unpublished Article"
    page.wont_have_content "Rails"
  end

  scenario "authors can't publish" do
    # Given an author's account
    # When I visit the new page
    visit new_article_path
    # There is no checkbox for 'published'
    page.wont_have_field('published')
  end

  scenario "authors can update their own articles if unpublished" do
    # Given an author's account
    # When I visit the edit page
    article = articles(:unpublished)
    visit edit_article_path(article)
    # Then I am able to submit the form
    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "No more typos"
    click_on "Update Article"
    page.must_have_content "Updated Title"
    page.wont_have_content "This is an article full of typos."
  end

  scenario "authors cant update their own articles if published" do
    # Given an author's account
    # When I try to visit the edit page of my published article
    article = articles(:published)
    visit edit_article_path(article)
    # Then I am redirected and given a notice
    current_path.must_equal articles_path
    page.must_have_content "You are not authorized to perform this action."
  end

  scenario "authors cant delete articles" do
    # Given an author's account
    # When I visit an article page
    article = articles(:published)
    visit article_path(article)
    # Then there is no option to delete
    page.wont_have_link "Delete"
    # There also wont be delete links on the index view
    visit articles_path
    page.wont_have_link "Delete"
  end
end
