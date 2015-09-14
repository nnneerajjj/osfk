class User < ActiveRecord::Base
  rolify
  has_paper_trail
  include ActiveModel::Dirty
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :async, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # https://github.com/plataformatec/devise/wiki/How-To%3a-Require-admin-to-activate-account-before-sign_in

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :reset_password_sent_at, :remember_me, 
                  :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip,
                  :last_sign_in_ip, :admin, :firstname, :notification_date, :active, :card_number, 
                  :street_number, :house_number, :lastname, :website, :telephone, :water, :stock, :approved,
                  :identity_number, :package1, :package2, :regular, :address, :postal_address, :role_ids,
                  :number, :home_phone, :login, :topic_ids, :participant_ids, :event_ids, :return_to

  has_attached_file :avatar, :styles => { :thumb => "250x250>", :preview => "80x80" }

  validates :firstname, :lastname, presence: true

  attr_accessor :login

  has_many :topics
  has_many :participants
  has_many :events, through: :participants

  def participates_in?(event)
    events.where(id: event.id).any?
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)

      if login =~ /^\d+$/
        where(conditions).where(["number = :value", value: login]).first
      else
        where(conditions).where(["lower(email) = :value", value: login.downcase]).first
      end
    else
      where(conditions).first
    end
  end

  def price
    price = 300
    price += 175 unless !!self.regular
    price += 200 if !!self.package1
    price += 1000 if !!self.package2
    return price
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

  def packages
    packages = []
    packages << 'Mossön' if package1
    packages << 'Drängsjön' if package2
    packages.to_sentence
  end

  def send_welcome_email
    UserMailer.delay.welcome_email(self)
  end

  def self.send_updated_email(updated, updater)
    updates = updated.previous_changes.except("encrypted_password",
                                              "updated_at",
                                              "created_at",
                                              "id")
    if updates.any?
      UserMailer.delay.user_changed_email(ENV['UPDATE_EMAIL_RECEIVERS'], updated, updater, updates)
    end
  end
end
