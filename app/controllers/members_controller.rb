class MembersController < ApplicationController

  def index
    authorize! :index, User.new

    @can_manage = can? :manage, User.new

    @users = User.order(:number)
  end

  def show
    @user = User.find(params[:id])
    authorize! :function, @user
  end

  def edit 
    @user = User.find(params[:id])
    authorize! :manage, @user
  end

  def update
    @user = User.find(params[:id])

    authorize! :manage, @user

    if @user.update_attributes(params[:user])
      User.send_updated_email(@user, current_user)
      flash[:notice] = "Användaren uppdaterad"
      redirect_to member_path(@user)
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def reset_password
    @user = User.find(params[:id])

    authorize! :manage, @user

    @user.send_reset_password_instructions

    flash[:notice] = "'Lösenord återställnings'-mail skickat till användaren"

    redirect_to member_path(@user)
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
end
