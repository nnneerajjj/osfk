class UploadsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    pp params
    upload = params[:upload]
    @upload = upload.keys.first.classify.constantize.new
    @upload.file = URI.parse(upload.values.first.gsub('%2F','/'))
    @upload.save
  end
end
