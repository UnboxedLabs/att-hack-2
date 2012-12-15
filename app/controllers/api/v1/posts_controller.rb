module Api
  module V1
    class PostsController < ApplicationController
      before_filter :retrieve_user
      before_filter :retrieve_post, only: [:up_vote, :down_vote]
      def create
        puts "POST PARAMS"
        puts params[:post].except(:avatar)
        post = @user.posts.build(params[:post])
        if post.save
          render json: { status: :ok, message: "Post created", post: post }, status: :created
        else
          puts "ERRORS #{post.errors.full_messages}"
          render json: { status: :error, message: "Unable to create post" }, status: :unprocessable_entity
        end

      end

      def index
        if params[:latitude].present? && params[:longitude].present?
          latitude, longitude = params[:latitude], params[:longitude]
          if params[:radius].present?
            posts = Post.near([latitude, longitude], params[:radius])
          else
            posts = Post.near([latitude, longitude], 5) # 5 Miles default
          end
        else
          render json: { status: :error, message: "No location provided" }, status: :bad_request and return
        end
        render json: { status: :ok, message: "Post list", posts: posts }, status: :ok
      end

      def show
        unless post = @user.posts.find(params[:post_id])
          render json: { status: :error, message: "Post not found" }, status: :not_found and return
        end

        render json: { status: :ok, message: "Post", post: post }, status: :ok
      end

      def up_vote
        begin
          @user.up_vote(@post)
        rescue
          render json: { status: :error, message: "You've already up voted for this post!" }, status: :ok and return
        end

        render json: { status: :ok, message: "Vote posted!", post: @post }, status: :ok
      end

      def down_vote
        begin
          @user.down_vote(@post)
        rescue
          render json: { status: :error, message: "You've already down voted for this post!" }, status: :ok and return
        end

        render json: { status: :ok, message: "Voted posted!", post: :post }, status: :ok
      end


      private
      def retrieve_post
        unless @post = Post.find(params[:post_id])
          render json: { status: :error, message: "Unable to find post" }, status: :not_found and return
        end

      end

      def retrieve_user
        unless @user = User.find(params[:user_id])
          render json: { status: :error, message: "User not found" }, status: :not_found and return
        end
      end
    end
  end
end
