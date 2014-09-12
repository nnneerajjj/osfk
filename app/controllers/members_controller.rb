class MembersController < ApplicationController
  before_filter :load_page

  def index
    authorize! :access, :admin
    @users = User.where(active: true)
  end

  def update_multiple
    authorize! :access, :admin
    @users = User.update(params[:users].keys, params[:users].values)
    flash[:alert] = @users.select { |x| x.errors.any? } .map { |x| x.errors.full_messages.to_sentence }.to_sentence

    redirect_to action: :index
  end

  private

  def load_page
    @page = Page.find_by_key('members')
    authorize! :read, @page
  end
end
