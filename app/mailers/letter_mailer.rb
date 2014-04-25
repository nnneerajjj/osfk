class LetterMailer < ActionMailer::Base
  include ActionView::Helpers::TextHelper

  default from: "\"BRF Caraten\" <kontakt@brfcaraten.se>"

  layout 'mailer'

  def email(letter, user)
    @letter = letter
    @user = user

    mail to: user.email, subject: letter.subject
  end
end
