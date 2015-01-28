class PagesController < ApplicationController
  load_and_authorize_resource only: [ :new, :destroy ]

  def show
    @page = Page.find_by_slug(params[:slug])
    authorize! :read, @page#, @page unless @page.public && !@page.locked?
  end

  def new
  end

  def edit
    @page = Page.find_by_slug(params[:id])
  end

  def create
    page = Page.new(params[:page])

    if page.save
      page.texts.create(key: 'content', value: page.content)
      flash[:notice] = "Du skapade sidan #{page.title}"
    end
    render json: page
  end

  def update
    @page = Page.find_by_slug(params[:id])
    @page.public = params[:page][:public] == 'true'

    authorize! :update, @page

    if @page.update_attributes(params[:page])
      flash[:notice] = "Du sparade nyheten"
    end
    render json: @page
  end

  def destroy
    @page.destroy
    flash[:notice] = "Du tog bort sidan."
    redirect_to action: :index
  end

end
