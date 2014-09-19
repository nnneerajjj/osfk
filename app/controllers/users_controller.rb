class UsersController < ApplicationController

  load_and_authorize_resource

  def index
  end

  def update
  #   if @user.update_attributes(params[:user])
  #     if params[:user][:password].present?
  #       flash[:info] = I18n.t(:password_changed)
  #       sign_in @user, bypass: true
  #     else
  #       flash[:info] = I18n.t(:settings_changed)
  #     end

  #     redirect_to users_path, notice: "yes"
  #   else
  #     flash[:alert] = @user.errors.full_messages.to_sentence
  #     render action: "index"
  #   end
  end
end
