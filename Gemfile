source 'https://rubygems.org'
#source 'https://ruby.taobao.org'

ruby '2.1.5'

gem 'rails'

gem 'pg'
gem 'rails_admin'
gem 'rails_admin_nestable'
gem 'jquery-rails'
gem 'thin'
gem 'devise'
gem 'devise-async'
gem 'rails-i18n'
gem 'cancancan'
gem 'aws-sdk'
gem 'acts_as_commentable_with_threading'
gem 'acts_as_list'
gem 'friendly_id'
gem 'nokogiri'
gem 'whenever', :require => false
gem 'airbrake'
gem 'postmark-rails'
gem 'rails_autolink'
gem 'daemons'
gem 'htmlentities'
gem 'date_time_attribute'
gem 'protected_attributes'
gem 'paperclip'
gem 'sidekiq'
gem 'kaminari'
gem 'paper_trail'
gem 's3_direct_upload'
gem 'rolify'
gem 'active_model_serializers', '0.8.0'
gem 'unicorn'
gem 'delayed_paperclip'
gem 'rails_admin_import', git: 'https://github.com/luddement/rails_admin_import.git', branch: 'utf8'
#gem 'rails_admin_import', path: '../Temp/rails_admin_import'

group :production do
  # Needed for heroku
  gem 'rails_12factor'
  gem 'pg'
end

group :development do
  gem 'byebug'
  gem 'quiet_assets'
  gem 'letter_opener'
  gem 'faker'
  gem 'dotenv-rails'
end

group :test do
  gem 'rspec-rails'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end
