class TakiController < ApplicationController
  # 404
  rescue_from ActionController::RoutingError,
    ActiveRecord::RecordNotFound,
    :with => :render_404 if Rails.env.production?

  # 500
  rescue_from Exception, :with => :render_500 if Rails.env.production?

  private
  def render_404(exception = nil)
    logger.info "404 Exception #{exception.message}" unless exception.nil?
    render :template => "errors/404", :status => 404, :layout => false, :content_type => 'text/html'
  end

  def render_500(exception = nil)
    logger.info "500 Exception #{exception.message}" unless exception.nil?
    render :template => "errors/500", :status => 500, :layout => false, :content_type => 'text/html'
  end
end
