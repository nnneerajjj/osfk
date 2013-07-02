class ContactMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper

  default from: 'kontakt@brfcaraten.se'

  def email(contact)
    @contact = contact
    mail to: @contact.email, subject: truncate(contact.content, length: 30)
  end
end
