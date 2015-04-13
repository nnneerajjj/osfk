class Page < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: :slugged

  attr_accessible :title, :content, :public, :header, :slug, :key, :text_ids, :page_id, :image_upload_ids, :role_id

  has_many :texts
  belongs_to :page
  belongs_to :role
  has_many :children, class_name: 'Page'

  has_many :image_uploads, as: :uploader

  validates :title, :content, presence: true

  scope :opened, where(public: true, key: nil)
  scope :closed, where(public: false)

  before_destroy :never_destroy_key_pages

  PUBLIC_PAGE_ID = "100000"
  PRIVATE_PAGE_ID = "200000"

  def description
    self.header.present? ? self.header : self.title
  end

  def text
    content.gsub(/<img .*?>/i, '')
  end

  def images
    doc = Nokogiri::HTML( content )
    imgs = doc.css('img').map{ |i| i['src'] }
    imgs.map { |img| img.gsub('/thumb/', '/large/').gsub('/original/', '/large/') }
  end

  def locked?
    self.key.present?
  end

  def empty_text?
    text == "<p></p>\r\n" || text == "<div></div>\r\n"
  end

  def path
    "/#{self.slug}"
  end

  private

  def never_destroy_key_pages
    if key.present?
      errors.add_to_base(I18n.t(:unable_to_destroy_key_pages))
      return false
    end
  end
end
