class ImageUpload < Upload
  has_attached_file :file, :styles => { :xxl => "1920x1200>", :large => "830x540>", :thumb => "250x250>", :preview => "80x80" }
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  attr_accessible :uploader_id, :uploader_type, :type, :uuid, :file

  process_in_background :file
end
