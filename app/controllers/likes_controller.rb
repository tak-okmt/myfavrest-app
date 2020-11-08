class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create destroy]

  def create
    @like = current_user.likes.create(post_id: like_params[:post_id])
    @post = Post.find(params[:post_id])
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy!
    @post = Post.find(params[:post_id])
  end

  private

  def like_params
    params.permit(:post_id, :community_id)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
