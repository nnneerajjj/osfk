class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def index
    redirect_to :edit
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    @user = self.resource

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      flash[:notice] = "Din profil är uppdaterad"
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      flash[:error] = resource.errors.full_messages.to_sentence
      render "edit"
    end
  end

  def create
    result = super
    flash[:error] = resource.errors.full_messages.to_sentence
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:firstname, :lastname, :telephone, :package1, :package2, :regular, :identity_number, :address, :postal_address ]
    devise_parameter_sanitizer.for(:account_update) << [:firstname, :lastname, :telephone, :identity_number, :address, :postal_address ]
  end

  def after_sign_up_path_for(resource)
    main_app.news_index_path
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
  end
end
