class News < ActiveRecord::Base
  extend FriendlyId
  acts_as_commentable

  friendly_id :subject, use: :slugged

  attr_accessible :subject, :content

  validates :subject, :content, presence: true

  scope :most_recent, order("created_at desc").limit(3)

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
end
