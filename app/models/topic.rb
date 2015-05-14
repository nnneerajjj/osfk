class Topic < ActiveRecord::Base
  extend FriendlyId
  acts_as_commentable
  has_paper_trail

  friendly_id :subject, use: :slugged

  attr_accessible :user, :subject, :content, :role_id, :public

  has_many :image_uploads, as: :uploader

  belongs_to :user
  belongs_to :role

  validates :user, :subject, :content, presence: true

  scope :most_recent, -> { order("id desc").limit(3) }

  def selected_role_id
    selected_role_id = public? ? Page::PUBLIC_PAGE_ID : Page::PRIVATE_PAGE_ID
    selected_role_id = role.id if role.present?
    selected_role_id
  end
end
