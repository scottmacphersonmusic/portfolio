require "test_helper"

feature "Editors have crud actions for comments" do
  before do
    # Given an editor role
    sign_in
  end

  scenario "editors can create comments" do
    # When I create a new comment
    visit new_article_comment_path(articles(:one))
    fill_in "Commenter name", with: "p-redditter"
    fill_in "Commenter url", with: "www.preddit.example"
    fill_in "Commenter email", with: "predditer@example.com"
    fill_in "Content", with: "Great point!"
    click_on "Submit Comment"
    # Then it is created
    page.must_have_content "Comment has been submitted to the editor for approval."
    page.must_have_content "Great point!"
  end

  scenario "editors can edit/approve comments" do
    # Given an article edit form
    visit edit_article_comment_path(articles(:one), comments(:rails))
    # When I click approved and submit
    fill_in "Commenter name", with: 'Oba'
    check("comment_approved")
    click_on "Submit Comment"
    # Then the comment is approved
    page.must_have_content "Comment was successfully updated."
    page.must_have_content "Oba"
  end

  scenario "editors can destroy comments" do
    # Given an article page with a comment
    visit article_path(articles(:one))
    # When I click delete on the comment
    page.find(".destroy").click
    # Then the comment is deleted
    page.must_have_content "Comment was successfully destroyed."
    page.wont_have_content "The Dude"
  end
end
