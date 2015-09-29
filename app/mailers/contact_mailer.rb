class ContactMailer < ApplicationMailer
  def contact_owner(user)
    mail to: "scottmacphersonmusic@gmail.com",
         subject: "Portfolio Message",
         from: user.email
  end
end
