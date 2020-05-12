class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    #検索オブジェクト
    @search = Post.ransack(params[:q])
    #検索結果
    @posts = @search.result
    @posts = @posts.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    @hash = Gmaps4rails.build_markers(@post) do |post, marker|
      marker.lat post.latitude
      marker.lng post.longitude
      marker.infowindow render_to_string(partial: 'posts/infowindow', locals: { post: post })
    end
  end

  def new
    @post = Post.new
    @code = Code.all
  end

  def edit
    @post = current_user.posts.find(params[:id])
    @code = Code.all
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
      params.require(:post).permit(:title, :description, :content, :image, :score, :area, :people, :prefecture_code, :rest_type, :objective, :features, :latitude, :longitude, :address)
    end
end