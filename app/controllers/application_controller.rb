class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.present?
      redirect_to main_app.root_path
    else
      session[:user_return_to] = request.fullpath
      redirect_to main_app.new_user_session_path
    end
  end

  private

  def set_locale
    if is_a? RailsAdmin::ApplicationController
      I18n.locale = :en
    else
      I18n.locale = :sv
    end
  end
end
