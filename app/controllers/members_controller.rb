class MembersController < ApplicationController
  before_filter :load_page

  def index
    authorize! :manage, User

    @users = User.order([:number, :lastname])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Användaren uppdaterad"
    else
      flash[:error] = @user.errors.full_messages.to_sentence
    end

    redirect_to :back
  end

  def update_multiple
    authorize! :manage, User
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
