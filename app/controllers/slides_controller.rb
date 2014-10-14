class SlidesController < ApplicationController
  load_and_authorize_resource :slide, only: [:show, :update]

  def index
    authorize! :create, Slide
  end

  def new
    @slide = Slide.new
  end

  def create
    slide = Slide.new(params[:slide])

    if slide.save
      flash[:notice] = "Du skapade slidern #{slide.header}"
    end
    render json: slide
  end

  def update
    if @slide.update_attributes(params[:slide])
      flash[:notice] = "Du sparade slidern #{@slide.header}"
    end
    render json: @slide
  end

  def show
  end
end
