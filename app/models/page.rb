class Page < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: :slugged

  attr_accessible :title, :content, :public, :header

  validates :title, :content, presence: true

  def description
    self.header.present? ? self.header : self.title
  end
end