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
      User.send_updated_email(@user, current_user)
      flash[:notice] = "Användaren uppdaterad"
      redirect_to member_path(@user)
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      return redirect_to :show
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.password = SecureRandom.hex(8)
    if @user.save
      User.send_updated_email(@user, current_user)
      flash[:notice] = "Användaren skapad"
      redirect_to member_path(@user)
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
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
