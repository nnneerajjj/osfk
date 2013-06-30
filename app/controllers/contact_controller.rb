class ContactController < ApplicationController
  def index
    @page = Page.find_by_key('contact')
  end

  def create
  end
end