Caraten::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  Dotenv.load

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  # Do not eager load code on boot.
  config.eager_load = false

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :letter_opener
  # config.action_mailer.smtp_settings = { :address => "localhost", :port => 1025 }
  # config.action_mailer.delivery_method = :postmark
  # config.action_mailer.postmark_settings = { :api_key => "0db97861-d148-47d0-ab1c-d3286628c630" }

  FROM_EMAIL = "fiske@osfk.org"
  FROM_HOST  = "http://#{config.action_mailer.default_url_options[:host]}"
  ActionMailer::Base.default from: "\"Österåkers sportfiskeklubb\" <#{FROM_EMAIL}>"

  require 'sidekiq/testing/inline'

  config.paperclip_defaults = {
    storage: :s3,
    s3_permissions: :public_read,
    bucket: ENV['S3_BUCKET'],
    s3_credentials: {
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET']
    }
  }
end
