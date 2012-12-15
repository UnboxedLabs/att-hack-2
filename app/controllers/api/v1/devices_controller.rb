module Api
  module V1
    class DevicesController < ApplicationController
      def create
        if @device = Device.find_by_uid(params[:device][:uid])
          msg =  { status: :ok, message: "Device already exists", device: @device, user: @device.user }
          render json: msg, status: :ok and return
        end

        @device = Device.new(params[:device])
        unless @device.valid?
          render json: { status: :error, message: "Device parameters not valid" }, status: :unprocessable_entity and return
        end

        if @device.save
          @user = User.create(name: "AnonymousUser#{@device.id}", temporary: true)
          @device.user = @user
          @device.save! # TODO - Move this logic once we have authentication scheme
          render json: { status: :ok, message: "Device and user created", device: @device, user: @user }, status: :ok
        else
           render json: { status: :error, message: "Unable to save device" }, status: :unprocessable_entity
        end
      end
    end
  end
end
