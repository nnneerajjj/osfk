class Slide < ActiveRecord::Base
  has_one :image_upload, as: :uploader

  attr_accessible :header, :header2, :content, :link, :image_upload, :image_upload_id
end
