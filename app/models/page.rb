class Page < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: :slugged

  attr_accessible :title, :content, :public, :header

  validates :title, :content, presence: true

  scope :opened, where(public: true, key: nil)
  scope :closed, where(public: false)

  before_destroy :never_destroy_key_pages
  before_save :dont_update_public_on_key_pages


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

  private

  def never_destroy_key_pages
    if key.present?
      errors.add_to_base(I18n.t(:unable_to_destroy_key_pages))
      return false
    end
  end

  def dont_update_public_on_key_pages
    if locked?
      self.public = true
    end
  end
end