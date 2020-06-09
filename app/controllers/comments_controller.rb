class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to posts_url, notice:"「#{@comment.post.title}」の口コミを登録しました。"
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to posts_url, notice: "「#{@comment.post.title}」の口コミを削除しました。"
    end
  end

  def new
    @post = Post.find_by(params[:post_id])
    @comment = Comment.new
    @code = Code.all
  end

  def edit
    @post = Post.find_by(params[:post_id])
    @comment = current_user.comments.find(params[:id])
    @code = Code.all
  end

  def show
    @comment = Comment.find(params[:id])
  end
    
  private
    def comment_params
      params.require(:comment).permit(:content, :post_id)
    end
end