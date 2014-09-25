class PagesController < ApplicationController
  load_resource

  def show
    @page = Page.find(params[:slug])
    authorize! :read#, @page unless @page.public && !@page.locked?
  end

  def new
  end

  def create
    page = Page.new(params[:page])
    pp page
    pp page
    pp page
    pp page
    if page.save
      flash[:notice] = "Du skapade sidan #{page.title}"
    end
    render json: page
  end
end
