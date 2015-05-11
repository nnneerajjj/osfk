class FileUpload < Upload
  has_attached_file :file, s3_headers: { 'Expires' => 1.year.from_now.httpdate }
  do_not_validate_attachment_file_type :file
  process_in_background :file

  attr_accessible :uploader_id, :uploader_type, :type, :uuid, :file


  def image?
    false
  end
end
