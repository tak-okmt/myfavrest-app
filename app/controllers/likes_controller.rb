class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:create, :destroy]

  def create
    @like = current_user.likes.create(like_params)
    @post = Post.find(params[:post_id])
  end

  def destroy
    @like = Like.find_by(like_params, user_id: current_user.id)
    @like.destroy
    @post = Post.find(params[:post_id])
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end

    def like_params
      params.permit(:post_id)
    end

end
