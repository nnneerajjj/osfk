class TextsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json


  def update
    authorize! :access, :admin

    json = JSON.parse(params[:text])

    key = json.keys.first
    text = json.values.first

    klass, id, attribute = key.split('-')

    @text = klass.camelize.constantize.find(id)
    @text.send("#{attribute}=", text)
    @text.save!

    respond_to do |format|
      format.json { render :json => @text }
    end
  end
end
