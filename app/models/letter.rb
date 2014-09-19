class Letter < ActiveRecord::Base
  attr_accessible :subject, :content, :link, :user_id, :sent_to_all_at

  belongs_to :user

  validates :subject, :content, :user, presence: true



  def send_to(user)
    LetterMailer.delay.email(self, user)
  end

  def send_to_all
    User.where(active: true).each do |user|
      send_to(user)
    end
    update_attribute(:sent_to_all_at, Time.now)
  end
end
