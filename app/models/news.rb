class News < ActiveRecord::Base
  extend FriendlyId
  acts_as_commentable
  has_paper_trail

  friendly_id :slug_candidates, use: :slugged

  attr_accessible :subject, :content, :active

  validates :subject, :content, presence: true

  default_scope -> { order('created_at DESC') }
  scope :active, where(active: true)

  def text
    content.gsub(/<img .*?>/i, '')
  end

  def images
    doc = Nokogiri::HTML( content )
    imgs = doc.css('img').map{ |i| i['src'] }
    imgs.map { |img| img.gsub('/thumb/', '/news/').gsub('/original/', '/news/') }
  end

  def thumbnail
    doc = Nokogiri::HTML( content )
    img = doc.css('img').map{ |i| i['src'] }[0] || 'newspaper.jpg'
    img.gsub('/original/', '/thumb/').gsub('/news/', '/thumb/')
  end

  def slug_candidates
    [
      :subject,
      [:subject, :text]
    ]
  end
end
