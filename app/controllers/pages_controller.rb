class PagesController < ApplicationController
  load_resource

  def show
    authorize! :read, @page unless @page.public
  end
end