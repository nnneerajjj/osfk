class Letter < ActiveRecord::Base
  attr_accessible :subject, :content, :send_after_save, :user_id

  after_save :send_email

  belongs_to :user

  validates :subject, :content, :user, presence: true

  def content_html

  end

  private

  def send_email
    if self.send_after_save
      User.all.each do |user|
        LetterMailer.delay.email(self, user.email)
      end

      self.update_column(:send_after_save, false)
    end
  end
end
