module Api
  module V1
    class PostsController < ApplicationController
      def create
        unless device = Device.find(params[:device_id])
          render json: { status: :error, message: "Device not found" }, status: :not_found and return
        end
        user = device.user
        post = user.posts.build(params[:post])
        if post.save
          render json: { status: :ok, message: "Post created", post: post }, status: :created
        else
          puts "ERRORS #{post.errors.full_messages}"
          render json: { status: :error, message: "Unable to create post" }, status: :unprocessable_entity
        end

      end

      def index
      end

      def show
      end
    end
  end
end
