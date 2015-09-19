require "test_helper"

feature "visitors have limited crud actions on comments" do

  scenario "Visitors can create comments" do
    # Given an existing article
    visit article_path(articles(:one))
    # When I create a new comment
    click_on "New Comment"
    fill_in "Name", with: "Troll"
    fill_in "URL", with: "www.troll.example"
    fill_in "Email", with: "troll@example.com"
    fill_in "Comment", with: "Troll like article"
    click_on "Submit Comment"
    # Then a new comment is submitted for approval
    page.must_have_content "Comment has been submitted to the editor for approval."
    # redirected to article, which doens't have comment yet
    page.wont_have_content "Troll like article"
  end

  # - - - Unhappy Paths - - -

  scenario "Visitors can't create invalid comments" do
    # Given a new article_comment form
    visit new_article_comment_path(articles(:one))
    # When I submit invalid comment data
    fill_in "Name", with: ""
    fill_in "Email", with: ""
    fill_in "Comment", with: ""
    click_on "Submit Comment"
    # Then no comment is submitted for approval
    page.must_have_content "error message"
    page.must_have_content "Name can't be blank"
    page.must_have_content "Email can't be blank"
    page.must_have_content "Comment can't be blank"
  end

  scenario "Visitors can't update comments" do
    # When I try to visit an edit article form
    visit edit_article_comment_path(articles(:one), comments(:rails))
    # Then I am redirected and see a message
    page.must_have_content "You aren't authorized to do that"
    page.wont_have_content "Edit Comment"
  end

  scenario "Visitors wont have edit or delete links available" do
    # When I view an article page with an existing comment
    visit article_path(articles(:one))
    # Then I wont have access to edit or delete links
    page.wont_have_link "Edit"
    page.wont_have_link "Delete"
  end
end
