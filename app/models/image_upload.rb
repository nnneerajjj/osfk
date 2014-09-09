class ImageUpload < Upload
  has_attached_file :file, :styles => { :large => "830x540>", :thumb => "250x250>", :preview => "80x80" }
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
end
