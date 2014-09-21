require 'paperclip/media_type_spoof_detector'

Paperclip::Attachment.default_options[:s3_host_name] = 's3-eu-west-1.amazonaws.com'

Paperclip.interpolates(:uuid) do |attachment, style|
  attachment.instance.uuid
end

module Paperclip
  class MediaTypeSpoofDetector
    def spoofed?
      false
    end
  end
end
