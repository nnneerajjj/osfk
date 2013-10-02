class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :number, :lastname, :website

  has_many :topics

  def name
    name = "#{firstname} #{lastname}"
    return email if name.blank?
    name
  end

  def fullname
    return name if number.nil?
    "#{name} (#{number})"
  end

  def send_notification
    if self.notification_date.nil?
      self.update_attribute(:notification_date, Time.now)
      return
    end

    date = Time.now - 4.month#self.notification_date
    self.update_attribute(:notification_date, Time.now)

    NotificationMailer.email(self, date).deliver!
  end
end
