class Letter < ActiveRecord::Base
  attr_accessible :subject, :content, :link, :send_after_save, :user_id

  after_save :send_email

  belongs_to :user

  validates :subject, :content, :user, presence: true

  private

  def send_email
    if self.send_after_save
      User.where(active: true).each do |user|
        LetterMailer.delay.email(self, user)
      end

      self.update_column(:send_after_save, false)
    end
  end
end
