class EventsController < ApplicationController
  include ActionView::Helpers::TextHelper

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

  def create
    params[:event][:subject] = params[:event][:subject].present? ? strip_tags(params[:event][:subject]) : ''
    params[:event][:location] = params[:event][:location].present? ? strip_tags(params[:event][:location]) : ''
    params[:event][:address] = params[:event][:address].present? ? strip_tags(params[:event][:address]) : ''

    event = Event.new(params[:event].merge(created_by_id: current_user.id))
    event.save
    render json: event
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
