class News < ActiveRecord::Base
  extend FriendlyId
  acts_as_commentable

  friendly_id :subject, use: :slugged

  attr_accessible :subject, :content, :start_date, :end_date

  validates :subject, :content, presence: true

  scope :most_recent, order("created_at desc").limit(3)
end
