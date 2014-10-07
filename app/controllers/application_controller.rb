class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.present?
      redirect_to main_app.news_index_path
    else
      session[:user_return_to] = request.fullpath
      redirect_to main_app.new_user_session_path
    end
  end
end
