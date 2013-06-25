class Topic < ActiveRecord::Base
  acts_as_commentable

  attr_accessible :user, :subject, :content

  belongs_to :user

  validates :user, :subject, :content, presence: true

  scope :most_recent, order("created_at desc").limit(3)
end
