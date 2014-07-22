class InspectionMailer < ActionMailer::Base

  def email_pdf(user,address, pdf)
    @user = user
    attachments['inventory.pdf'] = { mime_type: 'application/pdf', content: pdf.render }
    mail to: address, subject: 'Inventory PDF', from: 'info@myinventoryllc.com'
  end

end
