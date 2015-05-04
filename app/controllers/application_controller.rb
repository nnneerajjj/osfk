class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :load_menu

  def load_menu
    @menu = Page.where("page_id = '0' OR page_id is null").includes(children: :children)
  end

  def role_params(key)
    role_params = params[key]

    if role_params[:role_id] == Page::PUBLIC_PAGE_ID
      role_params[:public] = 'true'
      role_params[:role_id] = nil
    elsif role_params[:role_id] == Page::PRIVATE_PAGE_ID
      role_params[:public] = 'false'
      role_params[:role_id] = nil
    else
      role_params[:public] = 'false'
    end

    role_params
  end

  def load_roles
    @roles = [["Publik", Page::PUBLIC_PAGE_ID],["Medlemmar", Page::PRIVATE_PAGE_ID]] + Role.all.reverse.map { |role| [ role.display_name, role.id ] }
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
