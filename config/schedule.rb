# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#

env :PATH, ENV['PATH']
#env :GEM_PATH, ENV['GEM_PATH']

set :output, "/home/deploy/www/caraten/log/cron_log.log"

#set :job_template, "/usr/binbash -l -c ':job'"

every :reboot do
  # script "delayed_job start"
end

every 10.hours do
  # script "delayed_job restart"
end

every :saturday, :at => '10am' do # Use any day of the week or :weekend, :weekday
  script "send_notifications"
end

every 8.hours do
  script "s3backup"
end


#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
