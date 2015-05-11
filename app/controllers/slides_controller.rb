class SlidesController < ApplicationController
  load_and_authorize_resource :slide, only: [:show, :update, :destroy]

  def index
    authorize! :create, Slide
  end

  def new
    @slide = Slide.new
  end

  def create
    image_upload = ImageUpload.find(params[:slide].delete(:upload_id))
    slide = Slide.new(params[:slide])
    slide.image_upload = image_upload

    if slide.save
      flash[:notice] = "Du skapade slidern #{slide.header}"
    end
    render json: slide
  end

  def update
    @slide.image_upload = ImageUpload.find(params[:slide].delete(:upload_id))
    if @slide.update_attributes(params[:slide])
      flash[:notice] = "Du sparade slidern #{@slide.header}"
    end
    render json: @slide
  end

  def show
  end

  def destroy
    @slide.destroy
    flash[:notice] = "Du tog bort sliden."
    redirect_to action: :index
  end

end
