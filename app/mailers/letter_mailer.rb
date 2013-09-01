class LetterMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper

  default from: 'kontakt@brfcaraten.se'

  def email(letter, email)
    @letter = letter
    mail to: email, subject: letter.subject
  end
end
