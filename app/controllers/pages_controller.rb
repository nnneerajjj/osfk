class PagesController < ApplicationController
  load_and_authorize_resource only: [ :new, :destroy ]
  before_filter :load_roles, only: [ :new, :edit ]

  PUBLIC_PAGE_ID = "100000"
  PRIVATE_PAGE_ID = "200000"

  def show
    @page = Page.find_by_slug(params[:slug])
    authorize! :read, @page
  end

  def new
  end

  def edit
    @page = Page.find_by_slug(params[:id])

    set_selected_role_id

    authorize! :update, @page
  end

  def create
    page = Page.new(get_page_params)

    authorize! :create, page

    if page.save
      page.texts.create(key: 'content', value: page.content)
      flash[:notice] = "Du skapade sidan #{page.title}"
    end
    render json: page
  end

  def update
    @page = Page.find_by_slug(params[:id])
    page_params = get_page_params

    @page.public = page_params[:public] == 'true'
    @page.role_id = page_params[:role_id]

    authorize! :update, @page

    if @page.update_attributes(page_params)
      flash[:notice] = "Du sparade nyheten"
    end
    render json: @page
  end

  def destroy
    @page.destroy
    flash[:notice] = "Du tog bort sidan."
    redirect_to root_path
  end

  def set_selected_role_id
    @selected_role_id = @page.public? ? PUBLIC_PAGE_ID : PRIVATE_PAGE_ID
    role = @page.role
    if role.present?
      @selected_role_id = role.id
    end
  end

  def get_page_params
    page_params = params[:page]

    if page_params[:role_id] == PUBLIC_PAGE_ID
      page_params[:public] = 'true'
      page_params[:role_id] = nil
    elsif page_params[:role_id] == PRIVATE_PAGE_ID
      page_params[:public] = 'false'
      page_params[:role_id] = nil
    else
      page_params[:public] = 'false'
    end

    page_params
  end

  def load_roles
    @roles = [["Publik", PUBLIC_PAGE_ID],["Privat", PRIVATE_PAGE_ID]] + Role.all.reverse.map { |role| [ role.display_name, role.id ] }
  end
end
