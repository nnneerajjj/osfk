class ImageUpload < Upload
  has_attached_file :file, :styles => { :large => "1920x1200>", :medium => "830x550#", :small => "320x215#", :preview => "250x250#", :thumb => "80x80#" }
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  attr_accessible :uploader_id, :uploader_type, :type, :uuid, :file

  process_in_background :file, :processing_image_url => :processing_image_fallback

  def processing_image_fallback
    options = file.options
    options[:interpolator].interpolate(options[:url], file, :original)
  end
end
