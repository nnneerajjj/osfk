class UserMailer < ActionMailer::Base
  default from: 'kontakt@brfcaraten.se'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "#{I18n.t(:welcome_email_subject)}")
  end

  def test(email, subject)
    mail(:to email, subject: subject)
  end
end
