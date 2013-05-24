class Topic < ActiveRecord::Base
  acts_as_commentable

  attr_accessible :user, :subject, :content

  belongs_to :user

  validates :user, :subject, :content, presence: true
  #validates :subject, allow_blank: false
end
