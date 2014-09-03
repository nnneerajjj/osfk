class HomeController < ApplicationController
  def index
    @page = Page.find_by_key!('home')
  end
end
