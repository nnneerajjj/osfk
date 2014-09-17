class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :date_slug, use: :slugged
  date_time_attribute :start_date, :end_date
  belongs_to :created_by, class_name: 'User'

  validates :created_by, :subject, :start_date, presence: true
  validate :default_subject
  attr_accessible :subject, :content, :start_date_date, :end_date_date, :start_date_time, :end_date_time, :created_by, :created_by_id, :address, :location

  def date_slug
    if start_date.present?
      "#{start_date.strftime('%Y-%m-%d')}-#{subject}"
    end
  end

  def default_subject
    if subject == I18n.t(:default_event_subject)
      errors.add(:subject, :blank)
    end
  end
end
