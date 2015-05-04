class HomeController < ApplicationController
  def index
    @page = Page.find_by_key!('home')
    @slides = Slide.includes(:image_upload).shuffle
    @news = News.accessible_by(current_ability).limit(3)
  end

  def inactive
    @page = Page.find_by_key('inactive')
  end
end
