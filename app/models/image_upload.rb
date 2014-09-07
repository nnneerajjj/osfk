class ImageUpload < Upload
  has_attached_file :file, :styles => { :medium => "900x600>", :thumb => "250x250>", :preview => "80x80" }, path: "images/:uuid/:style/filename"
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/
end
