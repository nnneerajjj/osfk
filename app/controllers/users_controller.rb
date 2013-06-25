class UsersController < ApplicationController

  load_and_authorize_resource

  def index
  end

  def update
    if @user.update_attributes(params[:user])
      redirect_to users_path, notice: "yes"
    else
       render action: "index"
    end
  end
end

