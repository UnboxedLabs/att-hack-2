module Api
  module V1
    class DevicesController < ApplicationController
      def create
        render json: { status: "ok", message: "JaSON sucks" }, status: :ok
      end
    end
  end
end
