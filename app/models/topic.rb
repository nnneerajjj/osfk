class Topic < ActiveRecord::Base
  extend FriendlyId
  acts_as_commentable
  has_paper_trail

  friendly_id :subject, use: :slugged

  attr_accessible :user, :subject, :content

  has_many :image_uploads, as: :uploader

  belongs_to :user

  validates :user, :subject, :content, presence: true

  scope :most_recent, -> { order("id desc").limit(3) }
end
