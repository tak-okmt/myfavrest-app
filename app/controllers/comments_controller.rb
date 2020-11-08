class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :validate_comment, only: %i[edit update destroy]
  before_action :new_comment_limited, only: [:new]

  def create
    @post = Post.find(params[:post_id])
    @community = Community.find(params[:community_id])
    @code = Code.all

    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to community_post_url(@comment.post.community, @comment.post), notice: "「#{@comment.post.title}」の口コミを登録しました。"
    else
      render :new
    end
  end

  def update
    comment = Comment.find(params[:id])
    comment.update!(comment_params)
    redirect_to community_post_url(comment.post.community, comment.post), notice: "「#{comment.post.title}」の口コミを更新しました。"
  end

  def destroy
    return unless @comment.destroy

    redirect_to community_post_url(@comment.post.community, @comment.post), notice: "「#{@comment.post.title}」の口コミを削除しました。"
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @code = Code.all
  end

  def edit
    @post = Post.find(params[:post_id])
    @community = Community.find(params[:community_id])
    @code = Code.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:image, :score, :visitday, :content, :scene, :people, :post_id)
  end

  def validate_comment
    @comment = Comment.find(params[:id])
    redirect_to community_post_path(@comment.post.community, @comment.post) if @comment.user_id != current_user.id
  end

  def new_comment_limited
    @community = Community.find(params[:community_id])
    return if @community.user_belonging?(current_user)

    redirect_to community_post_path(@community, @community.post), alert: "所属ユーザのみ口コミができます"
  end
end
