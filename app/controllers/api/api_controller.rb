module Api
  class ApiController < ActionController::Base
    before_filter :set_default_response_format
    before_filter :restrict_access
    before_filter :params_incoming

    def params_incoming
      puts "Params Incoming!"
      puts params
    end
    private
    def restrict_access
      authenticate_or_request_with_http_token do |token, options|
        ApiKey.exists?(access_token: token)
      end
    end
    def set_default_response_format
      request.format = :json unless params[:format]
    end
  end

end