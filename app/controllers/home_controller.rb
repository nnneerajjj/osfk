class HomeController < ApplicationController
  def index
    "asdasd"
    @page = Page.find_by_key!('home')
  end
end
