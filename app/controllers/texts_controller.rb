class TextsController < ApplicationController
  skip_before_filter :verify_authenticity_token


  def update
    json = JSON.parse(params[:text])

    id = json.keys.first
    text = json.values.first

    @text = Text.find(id)
    @text.value = text
    @text.save!

    render nothing: true
  end
end
