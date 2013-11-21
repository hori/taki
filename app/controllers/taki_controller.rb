class TakiController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :detect_locale
  protect_from_forgery with: :exception

  def default_url_options(options = {})
    { :locale => I18n.locale }
  end

  def detect_locale
    I18n.locale = params[:locale]
  end
end
