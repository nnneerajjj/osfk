class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :content, :website, :secret

  attr_accessor :secret

  validates :name, :secret, :email, :content, presence: true

  after_create :send_email

  private

  def send_email
    ContactMailer.delay.email(self)
  end
end
