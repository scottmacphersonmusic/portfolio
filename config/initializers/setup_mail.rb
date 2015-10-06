unless Rails.env.production?
  ActionMailer::Base.smtp_settings = {
    address: "smtp.example.com",
    port:  3000,
    domain: "localhost"
  }
else
  ActionMailer::Base.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"],
    authentication: "plain",
    enable_starttls_auto: true
  }
end
