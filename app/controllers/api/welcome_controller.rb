module Api
  class WelcomeController < ApiController
    def ping
      render json: { status: "Ok", message: "Pinged!" }, status: :ok
    end
  end
end

