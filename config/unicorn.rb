# Hack to run sidekiq for free on heroku
# Remove when we move away from heroku
run_sidekiq_in_this_thread = %w(production).include?(ENV['RAILS_ENV'])
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 2)
timeout 30
preload_app true

@sidekiq_pid = nil

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  if run_sidekiq_in_this_thread
    @resque_pid ||= spawn("bundle exec sidekiq -C ./config/sidekiq.yml")
    puts 'Spawned sidekiq #{@request_pid}'
  end
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
