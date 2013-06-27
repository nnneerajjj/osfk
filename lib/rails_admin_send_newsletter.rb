require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdminSendNewsletter
end

module RailsAdmin
  module Config
    module Actions
      class SendNewsletter < RailsAdmin::Config::Actions::Base

      # Is the action on a model scope (Example: /admin/team/export)
       register_instance_option :collection? do
         true
       end

       register_instance_option :link_icon do
          'icon-share'
       end

       register_instance_option :pjax? do
           false
         end

        register_instance_option :controller do
          Proc.new do
              if request.xhr?
                  resources = Resource.where(:for_newsletter => true)
                  subscriber = Subscriber.all.each do |subscriber|
                     NewsletterMailer.delay.newsletter(subscriber, resources)
                  end
                  resources.each do |resource|
                        resource.update_column(:sent_on, Time.now)
                      end
              end
                flash[:success] = "The Newsletter has successfully been sent."
                redirect_to back_or_index
          end
      end


      end
    end
  end
end