class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def new
    super
    resource.regular = true
  end

  def create
    result = super
    flash[:alert] = resource.errors.full_messages.to_sentence
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:firstname, :lastname, :telephone, :package1, :package2, :regular, :identity_number, :address, :postal_address ]
  end

  def after_sign_up_path_for(resource)
    main_app.news_index_path
  end
end
