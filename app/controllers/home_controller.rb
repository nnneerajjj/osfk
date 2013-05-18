class HomeController < ApplicationController
  def index
  end

  private

  def set_locale
    I18n.locale = :sv
  end
end