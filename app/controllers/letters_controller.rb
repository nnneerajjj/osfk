class LettersController < ApplicationController
  load_and_authorize_resource :letter, only: [:show, :update, :send_letter]
  before_filter :setup_roles, only: [ :index, :send_letter ]

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

  def send_letter
    role = @roles.find { |role, role_id| role_id.to_s == params[:role_id] }.first
    users = retreive_users
    @letter.send_to_all(users)
    flash[:notice] = "Du skickade brevet \"#{@letter.subject}\" till totalt #{users.size} st. i gruppen #{role}"
    redirect_to :back
  end

  private

  def setup_roles
    @roles = [["Mig själv", Page::PRIVATE_PAGE_ID],["Alla aktiva", Page::PUBLIC_PAGE_ID]] + Role.all.reverse.map { |role| [ role.display_name, role.id ] }
  end

  def retreive_users
    role_id = params[:role_id]
    if role_id == Page::PRIVATE_PAGE_ID
      [ current_user ]
    elsif role_id == Page::PUBLIC_PAGE_ID
      User.where(approved: true)
    else
      Role.find(role_id).users
    end
  end
end
