class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    result = super
    flash[:alert] = resource.errors.full_messages.to_sentence
  end

  def update
    result = super
    flash[:alert] = resource.errors.full_messages.to_sentence
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:firstname, :lastname, :telephone, :package1, :package2, :regular, :identity_number, :address, :postal_address ]
    devise_parameter_sanitizer.for(:edit) << [:firstname, :lastname, :telephone, :identity_number, :address, :postal_address ]
  end

  def after_sign_up_path_for(resource)
    main_app.news_index_path
  end
end
