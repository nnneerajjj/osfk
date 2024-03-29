# RailsAdmin config file. Generated on May 16, 2013 22:00
# See github.com/sferik/rails_admin for more informations

require Rails.root.join('lib', 'rails_admin_send_newsletter.rb')

RailsAdmin.config do |config|
  ################  Global configuration  ################

  module RailsAdmin
    module Config
      module Actions
        class SendNewsletter < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
      end
    end
  end

  config.actions do
    # root actions
    dashboard                     # mandatory
    # collection actions
    index                         # mandatory
    new
    export
    history_index
    import
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app

    # Set the custom action here
    # send_newsletter do
    #   # Make it visible only for article model. You can remove this if you don't need.
    #   # visible do
    #   #   bindings[:abstract_model].model.to_s == "Article"
    #   # end
    # end
  end

  config.authorize_with :cancan

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['OSFK', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  # config.audit_with :history, 'User'

  # Or with a PaperTrail: (you need to install it first)
  # config.audit_with :paper_trail, 'User'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  # config.excluded_models = []

  # Include specific models (exclude the others):
  # config.included_models = []

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.

  config.model Letter do
    label 'Brev'
    label_plural 'Brev'
    navigation_label 'Brev'
    weight -10

    edit do
      field :subject
      field :link
      field :send_after_save

      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end

    list do
      field :subject
      field :content
      field :created_at
      field :updated_at
    end
  end

  config.model Page do
    label 'Sidor'
    label_plural 'Sidor'
    navigation_label 'Sidor'
    weight -1
  end

  config.model News do
    label 'Nyheter'
    label_plural 'Nyheter'
    navigation_label 'Nyheter'
    weight -1

    edit do
      field :subject
      field :active
      # field :start_date
      # field :end_date
    end

    list do
      field :subject
      field :content
      field :created_at
      field :updated_at
    end
  end

  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:


end
