class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(resource)
    main_app.news_index_path
  end
end
