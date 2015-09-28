require "test_helper"

feature "visitors have limited crud actions on project comments" do
  scenario "Visitors can create comments" do
    # Given an existing project
    visit project_path(projects(:hack))

    # When I create a new comment
    click_on "New Comment"
    fill_in 'Commenter name', with: "Troll"
    fill_in 'Commenter url', with: "www.troll.example"
    fill_in 'Commenter email', with: "troll@example.com"
    fill_in 'Content', with: "Troll like project"
    click_on "Submit Comment"
    # Then a new comment is submitted for approval
    page.must_have_content "Comment has been submitted to the editor for approval."
    # redirected to project, which doens't have comment yet
    page.wont_have_content "Troll like project"
  end

  scenario "Visitors should only see approved comments" do
    # Given existing comments for a project
    # When I visit an project's show page
    visit project_path(projects(:hack))
    # Then the unapproved comment should not be there
    page.must_have_content "The Dude"
  end

  # - - - Unhappy Paths - - -

  scenario "Visitors can't create invalid comments" do
    # Given a new project_comment form
    visit new_project_comment_path(projects(:hack))
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

  scenario "Visitors can't update comments" do
    # When I try to visit an edit comment form
    visit edit_project_comment_path(projects(:hack), comments(:dude_on_hack))
    # Then I am redirected and see a message
    page.must_have_content "You need to sign in or sign up before continuing."
    page.wont_have_content "Edit Comment"
  end

  scenario "Visitors wont have edit or delete links available" do
    # When I view an project page with an existing comment
    visit project_path(projects(:hack))
    # Then I wont have access to edit or delete links
    page.wont_have_link "Edit"
    page.wont_have_link "Delete"
  end
end

# feature "Editors have crud actions for comments" do
#   before do
#     # Given an editor role
#     sign_in
#   end

#   scenario "editors can create comments" do
#     # When I create a new comment
#     visit new_article_comment_path(articles(:rails))
#     fill_in "Commenter name", with: "p-redditter"
#     fill_in "Commenter url", with: "www.preddit.example"
#     fill_in "Commenter email", with: "predditer@example.com"
#     fill_in "Content", with: "Great point!"
#     click_on "Submit Comment"
#     # Then it is created
#     page.must_have_content "Comment has been submitted to the editor for approval."
#     page.must_have_content "Great point!"
#   end

#   scenario "editors can edit/approve comments" do
#     # Given an article edit form
#     visit edit_article_comment_path(articles(:rails), comments(:dude_on_rails))
#     # When I click approved and submit
#     fill_in "Commenter name", with: 'Oba'
#     check("comment_approved")
#     click_on "Submit Comment"
#     # Then the comment is approved
#     page.must_have_content "Comment was successfully updated."
#     page.must_have_content "Oba"
#     page.must_have_content "Approved: true"
#   end

#   scenario "editors can destroy comments" do
#     # Given an article page with a comment
#     visit article_path(articles(:rails))
#     # When I click delete on the comment
#     page.find(".destroy").click
#     # Then the comment is deleted
#     page.must_have_content "Comment was successfully destroyed."
#     page.wont_have_content "The Dude"
#   end
# end
