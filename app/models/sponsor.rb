class Sponsor < ActiveRecord::Base
  acts_as_list
  
  attr_accessible :logo, :url, :position

  has_attached_file :logo,
    default_url: '/images/:attachment/missing.png',
    styles: {
      normal: '220x'
    },
    default_style: :normal

  validates_attachment_content_type :logo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  validate :logo,
    presence: true

  validate :url,
    presence: true
  
  validate :validate_url

  default_scope { order('position ASC') }

  def validate_url
    begin
      uri = URI.parse(self.url)
      errors.add(:url, "is not valid") unless %w(http https).include?(uri.scheme)
    rescue URI::BadURIError, URI::InvalidURIError
      errors.add(:url, "is not valid") unless %w(http https).include?(uri.scheme)
    end
  end
end
