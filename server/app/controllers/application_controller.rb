class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class BadRequestError < StandardError; end

  def render(options = nil, extra_options = {}, &block)
    # Add success
    if options[:json].present? && options[:json][:success].nil?
      options[:json][:success] = true
    end

    super(options, extra_options, &block)
  end

  rescue_from StandardError do |e|
    render json: { success: false, message: e.message }
  end
end
