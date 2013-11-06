# encoding: utf-8

namespace :caraten do

  task :send_notifications => :environment do
    puts "sending notifications"
    print "sending notifications"
    # User.where(email: "luddement@gmail.com").each do |user|
    #   user.send_notification!
    #   print "#{Time.now} Sent email with notifications to #{user.email}\n"
    # end
  end

end
