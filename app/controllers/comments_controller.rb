class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to community_post_url(@comment.post.community,@comment.post), notice:"「#{@comment.post.title}」の口コミを登録しました。"
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to community_post_url(@comment.post.community,@comment.post), notice: "「#{@comment.post.title}」の口コミを削除しました。"
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @community = Community.find(params[:community_id])
    @comment = Comment.new
    @code = Code.all
  end

  def edit
    @post = Post.find(params[:post_id])
    @community = Community.find(params[:community_id])
    @comment = current_user.comments.find(params[:id])
    @code = Code.all
  end

  def show
    @comment = Comment.find(params[:id])
  end
    
  private
    def comment_params
      params.require(:comment).permit(:image,:title,:score,:visitday,:content,:scene,:people, :post_id)
    end

end