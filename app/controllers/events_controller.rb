class EventsController < ApplicationController
  include ActionView::Helpers::TextHelper

  load_and_authorize_resource :event, only: [:edit, :participate, :update, :destroy], find_by: :slug

  before_action :populate_dates, only: [:index, :show]

  def index

  end

  def show
    unless @event = Event.find_by_slug(params[:id])
      render :index
    end
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def participate
    if current_user.participates_in? @event
      current_user.events.delete(@event)
    else
      flash[:notice] = "Du är nu uppskriven på att deltaga på #{@event.subject}"
      current_user.events << @event
    end

    redirect_to :back
  end

  def create
    event = Event.new(params[:event].merge(created_by_id: current_user.id))
    event.save
    render json: event
  end

  def update
    if @event.update_attributes(params[:event])
      flash[:notice] = "Du sparade eventet"
    end
    render json: @event
  end

  def destroy
    @event.destroy
    flash[:notice] = "Du tog bort evenemanget."
    redirect_to action: :index
  end

  private

  def populate_dates
    @days = I18n.t(:'date.day_names')

    @current_month = Date.strptime(params[:id], "%Y-%m") rescue Time.now

    @next_month = @current_month + 1.month
    @prev_month = @current_month - 1.month
    @today = Time.now.to_date

    @beginning = @current_month.at_beginning_of_month
    @beginning = @beginning - @beginning.wday.day + 1.day
    @end = @current_month.at_end_of_month
    @end = @end + 7.days - @end.wday.day

    @events = Event.where(start_date: @current_month.at_beginning_of_month..@current_month.at_end_of_month)
  end
end
