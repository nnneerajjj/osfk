require 'carrierwave_direct'

CarrierWave.configure do |config|
  config.storage   = :fog  # Yep, this is hard coded. Use the :fog_provider setting if this needs to differ between environments
  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_credentials = {
      :provider              => Promote::Config.get(:fog_provider),
      :aws_access_key_id     => Promote::Config.get(:aws_access_key_id),
      :aws_secret_access_key => Promote::Config.get(:aws_secret_access_key),
      :region                => Promote::Config.get(:aws_region)
  }

  config.fog_directory   = Promote::Config.get(:aws_bucket_name)
  config.fog_public      = false
  config.max_file_size   = Promote::Config.get(:max_upload_size).to_i.megabytes
  config.enable_processing = true
  #config.fog_host        = 'https://s3.amazonaws.com' # optional, defaults to nil
  #config.fog_attributes  = { 'Cache-Control' => 'max-age=315576000' } # optional, defaults to {}
end



if Gem.latest_spec_for('carrierwave').version.to_s > "0.8.0"
  Rails.logger.warn("CarrierWave version is newer then 0.8.0, check if patch in CarrierWave initializor is still needed.")
end

CarrierWave::Uploader::Download.module_eval do
  # Patch from this pull request https://github.com/carrierwaveuploader/carrierwave/pull/1013
  # to properly handle brackets in file names
  def process_uri(uri)
    URI.parse(uri)
  rescue URI::InvalidURIError
    uri_parts = uri.split('?')
    # regexp from Ruby's URI::Parser#regexp[:UNSAFE], with [] specifically removed
    encoded_uri = URI.encode(uri_parts.shift, /[^\-_.!~*'()a-zA-Z\d;\/?:@&=+$,]/)
    encoded_uri << '?' << URI.encode(uri_parts.join('?')) if uri_parts.any?
    URI.parse(encoded_uri) rescue raise CarrierWave::DownloadError, "couldn't parse URL"
  end

end
