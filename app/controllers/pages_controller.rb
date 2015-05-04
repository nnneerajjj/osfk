class PagesController < ApplicationController
  load_and_authorize_resource only: [ :new, :destroy ]
  before_filter :load_roles, only: [ :new, :edit, :index ]

  def show
    @page = Page.find_by_slug(params[:slug])
    authorize! :read, @page
  end

  def index
    authorize! :create, Page.new

    @pages = Page.order(:key).includes(:page).all
  end

  def new
  end

  def edit
    @page = Page.find_by_slug(params[:id])

    authorize! :update, @page
  end

  def create
    page = Page.new(role_params(:page))

    authorize! :create, page

    if page.save
      page.texts.create(key: 'content', value: page.content)
      flash[:notice] = "Du skapade sidan #{page.title}"
    end
    render json: page
  end

  def update
    @page = Page.find_by_slug(params[:id])
    page_params = role_params(:page)

    @page.public = page_params[:public] == 'true'
    @page.role_id = page_params[:role_id]

    authorize! :update, @page

    if @page.update_attributes(page_params)
      flash[:notice] = "Du sparade sidan."
    end
    render json: @page
  end

  def destroy
    @page.destroy
    flash[:notice] = "Du tog bort sidan."
    redirect_to root_path
  end
end
