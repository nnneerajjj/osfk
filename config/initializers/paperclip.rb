Paperclip::Attachment.default_options[:s3_host_name] = 's3-eu-west-1.amazonaws.com'

Paperclip.interpolates(:uuid) do |attachment, style|
  attachment.instance.uuid
end