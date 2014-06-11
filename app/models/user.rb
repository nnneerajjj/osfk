class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname,
                  :street_number, :house_number, :lastname, :website, :telephone, :water, :stock

  has_many :topics

  after_create :send_welcome_email

  def name
    name = "#{firstname} #{lastname}"
    return email if name.blank?
    name
  end

  def fullname
    return name if street_number.nil?
    "#{name} (#{street_number})"
  end

  def send_notification!
    if self.notification_date.nil?
      self.update_attribute(:notification_date, Time.now)
      return
    end

    date = Time.now - (Time.now - self.notification_date)
    self.update_attribute(:notification_date, Time.now)

    # Override date logic with just plain with 1.week.ago
    #date = 1.week.ago

    NotificationMailer.delay.email(self, date)
  end

  private

  def send_welcome_email
    UserMailer.delay.welcome_email(self)
  end
end
