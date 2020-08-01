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
    @avg_score = avg_score(@post)
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
    @community = Community.find_by(params[:community_id])
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
    @community = Community.find_by(params[:community_id])
    @code = Code.all
    
    if @post.save
      redirect_to communities_url, notice:"お店「#{@post.title}」を登録しました。"
    else
      render :new
    end
  end

  def update
    post = current_user.posts.find(params[:id])
    post.update!(post_params)
    redirect_to communities_url notice:"お店「#{post.title}」を更新しました。"
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to communities_url, notice: "お店「#{post.title}」を削除しました。"
  end

  private

    def post_params
      params.require(:post).permit(:title, :description, :image, :area, :prefecture_code, :rest_type, :address, :community_id)
    end

    # コメントの並び替え
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

    # 店舗の評価平均
    def avg_score(post)
      ttl_score = 0
      post.comments.each do |c|
        c.score = 0 if c.score.nil?
        ttl_score += c.score
      end
      avg = ttl_score.fdiv(post.comments.length).round(1)
    end

end