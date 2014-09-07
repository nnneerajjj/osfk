S3DirectUpload.config do |c|
  c.access_key_id = ENV['S3_KEY']
  c.secret_access_key = ENV['S3_SECRET']
  c.bucket = ENV['S3_BUCKET']
  c.region = ENV['S3_REGION']
  c.url = nil
end
