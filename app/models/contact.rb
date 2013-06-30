class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :content, :website, :secret

  attr_accessor :secret

  validates :name, :secret, :email, :content, presence: true
end
