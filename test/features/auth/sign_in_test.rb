require 'test_helper'

feature "Users can sign in" do
  scenario "sign in with github works" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:github,
                             {
                               uid: '12345',
                               info: { nickname: 'test_github_user'},
                             })
    visit root_path
    Capybara.current_session.driver.request.env['devise.mapping'] = Devise.mappings[:user]
    Capybara.current_session.driver.request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]

    click_on "Sign In with Github"
    fill_in "Email", with: 'test_twitter_user@example.com'
    click_on "Sign Up"
    page.must_have_content "Welcome! You have signed up successfully."
  end
end
