class Slide < ActiveRecord::Base
  has_one :image_upload, as: :uploader, class_name: 'ImageUpload', foreign_key: "uploader_id"

  attr_accessible :header, :header2, :content, :link, :image_upload, :image_upload_id
end
