class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
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