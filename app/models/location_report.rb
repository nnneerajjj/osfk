class LocationReport < ActiveRecord::Base
  belongs_to :user
  attr_accessible :latitude, :longitude, :comment

  paginates_per 20

  scope :today, -> { where('created_at >= ?', 24.hours.ago) }

end
