class ContactMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper

  default from: "\"BRF Caraten\" <kontakt@brfcaraten.se>"

  layout 'mailer'

  def email(contact)
    @contact = contact
    mail to: 'kontakt@brfcaraten.se', subject: "#{I18n.t(:contact_message_from, name: @contact.name)}: #{truncate(contact.content, length: 30)}"
  end
end
