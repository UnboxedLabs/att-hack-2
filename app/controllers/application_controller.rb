class ApplicationController < ActionController::Base
  before_filter :set_default_response_format

private
  def set_default_response_format
    request.format = :json unless params[:format]
  end
end
