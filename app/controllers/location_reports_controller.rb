class LocationReportsController < ApplicationController
  before_action :set_location_report, only: [:show, :edit, :update, :destroy]
  before_action :set_page, only: [:all_requests, :index]

  def all
    authorize! :read, LocationReport
    @location_reports = LocationReport.order('id DESC').page(@page_no)
  end

  # GET /location_reports
  def index
    authorize! :read, LocationReport
    @location_reports = LocationReport.today.order('id DESC').page(@page_no)
  end

  # GET /location_reports/1
  def show
    authorize! :read, LocationReport
  end

  # GET /location_reports/new
  def new
    authorize! :create, LocationReport
    @location_report = LocationReport.new
  end

  # GET /location_reports/1/edit
  def edit
  end

  # POST /location_reports
  def create
    authorize! :create, LocationReport
    @location_report = LocationReport.new(location_report_params)
    @location_report.user = current_user
    if @location_report.save
      redirect_to location_reports_path, notice: 'Location report was successfully created.'
    else
      render :new
    end
  end

  # # PATCH/PUT /location_reports/1
  # def update
  #   if @location_report.update(location_report_params)
  #     redirect_to @location_report, notice: 'Location report was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # DELETE /location_reports/1
  def destroy
    @location_report.destroy
    redirect_to location_reports_url, notice: 'Location report was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location_report
      @location_report = LocationReport.find(params[:id])
    end

    def set_page
      @page_no = params[t(:page)] || params["page"] || 1
    end

    # Only allow a trusted parameter "white list" through.
    def location_report_params
      params.require(:location_report).permit(:comment, :latitude, :longitude)
    end

end
