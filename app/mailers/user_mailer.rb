class UserMailer < ActionMailer::Base
  layout 'mailer'

  def welcome_email(user)
    @user = user

    mail(to: @user.email, subject: "#{I18n.t(:welcome_email_subject)}")
  end

  def user_changed_email(email, updated_user, updater_user, updates)
    @created = updates["email"] && updates["email"].first.blank? && updates["email"].last.present?

    if @created
      @subject = "Ny medlemsansökan: #{updated_user.name}"
    else
      updater = updated_user != updater_user ? " (Ändrad av #{updater_user.name})" : ''
      @subject = "Uppdaterad medlem: [#{updated_user.number}] #{updater_user.name} #{updater}"
    end

    @updated_user = updated_user
    @updates = updates

    mail(to: email, subject: @subject)
  end

  def test(email, subject)
    @user = User.find_by_email("caterpiller@gmail.com")
    mail(to: email, subject: subject)
  end
end
