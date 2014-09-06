class RegistrationsController < ApplicationController
  protected

  def after_sign_up_path_for(resource)
    raise main_app.news_index_path
  end
end
