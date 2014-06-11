class InspectionMailer < ActionMailer::Base

  def email_pdf(address, pdf)
    attachments['inspection.pdf'] = { mime_type: 'application/pdf', content: pdf.render }
    mail to: address, subject: 'Inspection PDF', from: 'info@myinventoryllc.com'
  end

end
