class News < ActiveRecord::Base
  acts_as_commentable

  attr_accessible :subject, :content, :start_date, :end_date

  validates :subject, :content, presence: true
end
