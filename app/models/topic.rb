class Topic < ActiveRecord::Base
  extend FriendlyId
  acts_as_commentable

  friendly_id :subject, use: :slugged

  attr_accessible :user, :subject, :content

  has_many :image_uploads, as: :uploader

  belongs_to :user

  validates :user, :subject, :content, presence: true

  scope :most_recent, order("created_at desc").limit(3)
end
