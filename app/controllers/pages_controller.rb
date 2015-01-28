class PagesController < ApplicationController
  #load_resource only: [ :new, :destroy, :update ]
  load_and_authorize_resource only: [ :destroy, :update ]

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
    page = Page.new(params[:page].merge({page_id: Page.find_by_key('home').id}))

    if page.save
      page.texts.create(key: 'content', value: page.content)
      flash[:notice] = "Du skapade sidan #{page.title}"
    end
    render json: page
  end

  def update
    if @news.update_attributes(params[:news])
      flash[:notice] = "Du sparade nyheten"
    end
    render json: @news
  end

  def destroy
    @page.destroy
    flash[:notice] = "Du tog bort sidan."
    redirect_to action: :index
  end

end
