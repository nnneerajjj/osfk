class LettersController < ApplicationController
  load_and_authorize_resource :letter, only: [:show, :update, :send_me, :send_all]

  def index
    authorize! :create, Letter
  end

  def new
    @letter = Letter.new
  end

  def create
    letter = Letter.new(params[:letter])
    letter.user_id = current_user.id
    if letter.save
      flash[:notice] = "Du skapade brevet #{letter.subject}"
    end
    render json: letter
  end

  def update
    if @letter.update_attributes(params[:letter])
      flash[:notice] = "Du sparade brevet #{@letter.subject}"
    end
    render json: @letter
  end

  def show
  end

  def send_me
    LetterMailer.email(@letter, current_user).deliver!
    flash[:notice] = "Du skickade brevet \"#{@letter.subject}\" till dig själv"
    redirect_to :back
  end

  def send_all
    @letter.send_to_all
    flash[:notice] = "Du skickade brevet \"#{@letter.subject}\" till alla"
    redirect_to :back
  end
end
