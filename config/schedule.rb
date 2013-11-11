# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/home/deploy/www/caraten/log/cron_log.log"

every :reboot do
  command "cd :path && script/delayed_job start"
end

#This will start delayed job on every server boot. You may also write
every 10.hours do
  command "cd :path && script/delayed_job restart"
end

every :saturday, :at => '9am' do # Use any day of the week or :weekend, :weekday
  command "cd :path && script/send_notification"
end

every :weekday, :at => '10am' do # Use any day of the week or :weekend, :weekday
  command "cd :path && script/send_notification"
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
