class Page < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title, use: :slugged

  attr_accessible :title, :content, :public, :header
end
