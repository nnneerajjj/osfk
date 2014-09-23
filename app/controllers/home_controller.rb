class HomeController < ApplicationController
  def index
    @page = Page.find_by_key!('home')
    @slides = Slide.includes(:image_upload).shuffle
  end

  def inactive
  end
end
