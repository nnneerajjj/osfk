class EventsController < ApplicationController

  before_action :populate_dates, only: [:index, :show]

  def index

  end

  def show
    render :index
  end

  def new
    @event = Event.new
  end

  def create
    event = Event.new(params[:event].merge(created_by_id: current_user.id))
    event.save
    render json: event
  end

  private

  def populate_dates
    @days = I18n.t(:'date.day_names').rotate(1)

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
