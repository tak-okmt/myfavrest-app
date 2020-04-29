class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    #検索オブジェクト
    @search = Post.ransack(params[:q])
    #検索結果
    @posts = @search.result
    @posts = @posts.page(params[:page]).per(3)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      redirect_to posts_url, notice:"投稿「#{@post.title}」を登録しました。"
    else
      render :new
    end
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    redirect_to posts_url notice:"投稿「#{post.title}」を更新しました。"
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_url, notice: "投稿「#{post.title}」を削除しました。"
  end

  private

    def post_params
      params.require(:post).permit(:title, :description, :content)
    end
end