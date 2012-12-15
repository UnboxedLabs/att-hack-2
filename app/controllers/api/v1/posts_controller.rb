module Api
  module V1
    class PostsController < ApplicationController
      before_filter :retrieve_user
      def create
        post = @user.posts.build(params[:post])
        if post.save
          render json: { status: :ok, message: "Post created", post: post }, status: :created
        else
          puts "ERRORS #{post.errors.full_messages}"
          render json: { status: :error, message: "Unable to create post" }, status: :unprocessable_entity
        end

      end

      def index
        posts = @user.posts
        render json: { status: :ok, message: "Post list", posts: posts }, status: :ok
      end

      def show
      end

      private

      def retrieve_user
        unless @user = User.find(params[:user_id])
          render json: { status: :error, message: "User not found" }, status: :not_found and return
        end
      end
    end
  end
end
