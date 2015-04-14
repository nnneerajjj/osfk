class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :load_menu

  def load_menu
    @menu = Page.where("page_id = '0' OR page_id is null").includes(children: :children)
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.present?
      redirect_to main_app.news_index_path
    else
      session[:user_return_to] = request.fullpath
      redirect_to main_app.new_user_session_path
    end
  end
end
