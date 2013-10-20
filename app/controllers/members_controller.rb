class MembersController < ApplicationController
  before_filter :load_page

  def index
    @users = User.order(:number)
  end

  private

  def load_page
    @page = Page.find_by_key('members')
  end
end
