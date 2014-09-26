class PagesController < ApplicationController
  load_resource

  def show
    @page = Page.find_by_slug(params[:slug])
    authorize! :read, @page#, @page unless @page.public && !@page.locked?
  end

  def new
  end

  def create
    page = Page.new(params[:page].merge({page_id: Page.find_by_key('home').id}))

    if page.save
      page.texts.create(key: 'content', value: page.content)
      flash[:notice] = "Du skapade sidan #{page.title}"
    end
    render json: page
  end
end
