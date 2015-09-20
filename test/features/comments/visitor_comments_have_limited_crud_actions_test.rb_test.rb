require "test_helper"

feature "visitors have limited crud actions on comments" do

  scenario "Visitors can create comments" do
    # Given an existing article
    visit article_path(articles(:one))
    # When I create a new comment
    click_on "New Comment"
    fill_in 'Commenter name', with: "Troll"
    fill_in 'Commenter url', with: "www.troll.example"
    fill_in 'Commenter email', with: "troll@example.com"
    fill_in 'Content', with: "Troll like article"
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
    fill_in "Commenter name", with: ""
    fill_in "Commenter email", with: ""
    fill_in "Content", with: ""
    click_on "Submit Comment"
    # Then no comment is submitted for approval
    page.must_have_content "3 errors prohibited this comment from being saved:"
    page.must_have_content "Commenter name can't be blank"
    page.must_have_content "Commenter email can't be blank"
    page.must_have_content "Content can't be blank"
  end

  # scenario "Visitors can't update comments" do
  #   # When I try to visit an edit article form
  #   visit edit_article_comment_path(articles(:one), comments(:rails))
  #   # Then I am redirected and see a message
  #   page.must_have_content "You aren't authorized to do that"
  #   page.wont_have_content "Edit Comment"
  # end

  # scenario "Visitors wont have edit or delete links available" do
  #   # When I view an article page with an existing comment
  #   visit article_path(articles(:one))
  #   # Then I wont have access to edit or delete links
  #   page.wont_have_link "Edit"
  #   page.wont_have_link "Delete"
  # end
end
