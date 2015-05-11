class News < ActiveRecord::Base
  extend FriendlyId
  acts_as_commentable
  has_paper_trail

  friendly_id :slug_candidates, use: :slugged

  attr_accessible :subject, :content, :active, :upload_ids, :role_id, :public

  validates :subject, :content, presence: true
  validate :default_subject

  belongs_to :role
  has_many :image_uploads, as: :uploader
  has_many :file_uploads, as: :uploader
  has_many :uploads, as: :uploader

  default_scope -> { order(id: :desc) }
  scope :active, -> { where(active: true) }

  def text
    content.gsub(/<img .*?>/i, '')
  end

  def selected_role_id
    selected_role_id = public? ? Page::PUBLIC_PAGE_ID : Page::PRIVATE_PAGE_ID
    selected_role_id = role.id if role.present?
    selected_role_id
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
