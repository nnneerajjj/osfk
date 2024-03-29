Caraten::Application.configure do
    # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both thread web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true


  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_assets = false

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.0'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = ENV['LOG_LEVEL'] || :warn

  # Prepend all log lines with the following tags.
  config.log_tags = [ :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  #config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

  #config.assets.precompile += %w( *.svg *.eot *.woff *.ttf admin.js modernizr-2.6.2-respond-1.1.0.min.js )
  config.assets.precompile += %w( admin.js modernizr-2.6.2-respond-1.1.0.min.js )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  config.action_mailer.default_url_options = { :host => 'osfk.herokuapp.com' }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :postmark
  config.action_mailer.postmark_settings = { :api_key => ENV['POSTMARK_API_KEY'] }
  #config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #      :authentication => :plain,
  #      :address => 'smtp.postmarkapp.com',
  #      :port => 25,
  #      :domain => "brfcaraten.se",
  #      :user_name => '0db97861-d148-47d0-ab1c-d3286628c630',
  #      :password => '0db97861-d148-47d0-ab1c-d3286628c630'
  # }
  # config.action_mailer.smtp_settings = {
  #      :authentication => :plain,
  #      :address => 'smtp.mailgun.org',
  #      :port => 587,
  #      :domain => "brfcaraten.se",
  #      :user_name => 'postmaster@brfcaraten.se',
  #      :password => '3e5xs6znvfj0'
  # }

  FROM_EMAIL = "fiske@osfk.org"
  FROM_HOST  = "http://#{config.action_mailer.default_url_options[:host]}"
  ActionMailer::Base.default from: "\"Österåkers sportfiskeklubb\" <#{FROM_EMAIL}>"

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

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
