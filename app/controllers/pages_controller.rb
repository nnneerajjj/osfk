class PagesController < ApplicationController
  load_resource

  def show
    @page = Page.find(params[:slug])
    authorize! :read, @page unless @page.public && !@page.locked?
  end
end
