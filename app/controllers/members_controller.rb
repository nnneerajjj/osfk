class MembersController < ApplicationController
  before_filter :load_page

  def index
    authorize! :access, :admin
    @users = User.where(active: true)
  end

  private

  def load_page
    @page = Page.find_by_key('members')
    authorize! :read, @page
  end
end
