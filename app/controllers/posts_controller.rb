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
    if @post.prefecture_code.present?
      @pref_name = @post.prefecture.name
    else
      @pref_name = ""
    end
    @comments = @post.comments
    @comments = set_comment_order(@comments, params[:comment_order])
    @comment = Comment.new
  end

  def new
    @community = Community.find_by(post_params[:community_id])
    @post = Post.new
    @code = Code.all
  end

  def edit
    @community = Community.find_by(params[:community_id])
    @post = current_user.posts.find(params[:id])
    @code = Code.all
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      redirect_to communities_url, notice:"投稿「#{@post.title}」を登録しました。"
    else
      render :new
    end
  end

  def update
    post = current_user.posts.find(params[:id])
    post.update!(post_params)
    redirect_to communities_url notice:"投稿「#{post.title}」を更新しました。"
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy
    redirect_to communities_url, notice: "投稿「#{post.title}」を削除しました。"
  end

  private

    def post_params
      params.require(:post).permit(:title, :description, :content, :image, :score, :area, :people, :prefecture_code, :rest_type, :objective, :features, :latitude, :longitude, :address, :community_id)
    end

    def set_comment_order(comments, cmnt_order)
      order_key = 'updated_at'
      case cmnt_order
      when 'updated_at'
        order_key = 'updated_at'
      when 'score'
        order_key = 'score'
      when 'visitday'
        order_key = 'visitday'
      end
      comments.order(order_key)
    end

end