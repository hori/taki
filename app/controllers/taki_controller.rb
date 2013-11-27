class TakiController < ApplicationController
  before_filter :detect_locale

  # 404
  rescue_from ActionController::RoutingError,
    ActiveRecord::RecordNotFound,
    :with => :render_404 if Rails.env.production?

  # 500
  rescue_from Exception, :with => :render_500 if Rails.env.production?

  private
  def default_url_options(options = {})
    { :locale => I18n.locale }
  end

  def detect_locale
    I18n.locale = params[:locale]
  end

  def render_404(exception = nil)
    logger.info "404 Exception #{exception.message}" unless exception.nil?
    render :template => "errors/404", :status => 404, :layout => false, :content_type => 'text/html'
  end

  def render_500(exception = nil)
    logger.info "500 Exception #{exception.message}" unless exception.nil?
    render :template => "errors/500", :status => 500, :layout => false, :content_type => 'text/html'
  end
end
