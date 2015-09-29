require "test_helper"

feature "Contact delivers mail" do
  include EmailSpec::Helpers
  include EmailSpec::Matchers

  scenario "visitors can email me through the contact page" do
    # Given a contact form
    visit contacts_path
    # When a visitor fills out the required fields
    fill_in "Name", with: "John Coltrane"
    fill_in "Email", with: "trane@example.com"
    fill_in "Message", with: "a love supreme"
    email = ContactMailer.contact_owner
    # And clicks 'Send'
    click_on "Send"
    # Then an email should be delivered to me
    email.must reply_to("trane@example.com")
    email.must deliver_to "scottmacphersonmusic@gmail.com"
    email.must have_subject "Portfolio Message"
    email.must have_body_text "John Coltrane says:"
  end
end
