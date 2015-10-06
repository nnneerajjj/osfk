class LocationReportSerializer < ActiveModel::Serializer
  attributes :id, :comment, :latitude, :longitude
  has_one :user
end
