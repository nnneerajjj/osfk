class News < ActiveRecord::Base
  extend FriendlyId
  acts_as_commentable
  has_paper_trail

  friendly_id :slug_candidates, use: :slugged

  attr_accessible :subject, :content, :active, :image_upload_ids

  validates :subject, :content, presence: true
  validate :default_subject

  has_many :image_uploads, as: :uploader

  default_scope -> { order('id DESC') }
  scope :active, -> { where(active: true) }

  def text
    content.gsub(/<img .*?>/i, '')
  end

  def slug_candidates
    [
      :subject
    ]
  end

  def default_subject
    if subject == I18n.t(:default_news_subject)
      errors.add(:subject, :blank)
    end
  end
end
