class ContactMailer < ActionMailer::Base
  default to: "jmophoto@me.com"

  def contact_form(message)
    @message = message
    mail from: @message.email, subject: "Contact Form Message from #{@message.name}"
  end
end
