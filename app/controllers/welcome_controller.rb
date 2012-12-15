class WelcomeController < ApplicationController
  def ping
    render json: { status: "Ok", message: "Pinged!" }, status: :ok
  end
end
