class User < ActiveRecord::Base
  rolify
  has_paper_trail
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # https://github.com/plataformatec/devise/wiki/How-To%3a-Require-admin-to-activate-account-before-sign_in

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname,
                  :street_number, :house_number, :lastname, :website, :telephone, :water, :stock, :approved,
                  :identity_number, :package1, :package2, :regular, :address, :postal_address, :role_ids

  has_attached_file :avatar, :styles => { :thumb => "250x250>", :preview => "80x80" }

  validates :firstname, :lastname, presence: true

  has_many :topics
  has_many :participants
  has_many :events, through: :participants

  def participates_in?(event)
    events.where(id: event.id).any?
  end

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

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  private

  def send_welcome_email
    UserMailer.delay.welcome_email(self)
  end
end
