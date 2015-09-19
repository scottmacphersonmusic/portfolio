require "test_helper"

feature "Editors have crud actions for comments" do
  before do
    # Given an editor role
    sign_in
  end

  scenario "editors can create comments" do
    # When I create a new comment
    visit new_article_comment_path(articles(:one))
    fill_in "Name", with: "p-redditter"
    fill_in "URL", with: "www.preddit.example"
    fill_in "Email", with: "predditer@example.com"
    fill_in "Comment", with: "Great point!"
    click_on "Submit Comment"
    # Then it is created
    page.must_have_content "Your comment has been submitted for approval."
    page.wont_have_content "Great point!"
  end

  scenario "editors can edit/approve comments" do
    # Given an article edit form
    visit edit_article_comment_path(articles(:one), comments(:rails))
    # When I click approved and submit
    check("Approved")
    click_on "Update Comment"
    # Then the comment is approved
    page.must_have_content "Comment has been approved"
    page.must_have_content "comment content - see fixture"
  end

  scenario "editors can destroy comments" do
    # Given an article page with a comment
    visist article_path(articles(:one))
    # When I click delete on the comment
    page.find('comment links').click_on "Destroy"
    # Then the comment is deleted
    page.must_have_content "Comment successfully destroyed."
    page.wont_have_content "comment content - see fixture"
  end
end
