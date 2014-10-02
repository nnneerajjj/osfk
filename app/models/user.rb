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
                  :identity_number, :package1, :package2, :regular, :address, :postal_address, :role_ids,
                  :number, :home_phone

  has_attached_file :avatar, :styles => { :thumb => "250x250>", :preview => "80x80" }

  validates :firstname, :lastname, presence: true

  has_many :topics
  has_many :participants
  has_many :events, through: :participants

  def participates_in?(event)
    events.where(id: event.id).any?
  end

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
    super && (approved? || admin?)
  end

  # mosso

  def inactive_message
    unless approved?
      :not_approved
    else
      super # Use whatever other message
    end
  end

  def before_import_save(row, map)
    if map.has_key?(:pre_email)
      if row[map[:pre_email]].blank?
        self.email = "#{number}@temp.osfk.org"
      else
        self.email = row[map[:pre_email]].to_s.gsub(/\s|:/, '')
      end
    end

    name = row[map[:name]]
    if name.present?
      self.firstname = name.split[0..-2].join(' ')
      self.firstname = name if self.firstname.blank?
      self.lastname = name.split.last
    end

    unless self.encrypted_password.present?
      self.password = SecureRandom.hex(8)
    end
  end

  def send_welcome_email
    UserMailer.delay.welcome_email(self)
  end
end
