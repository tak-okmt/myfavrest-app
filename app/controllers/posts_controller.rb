class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :validate_post, only: %i[edit update destroy]
  before_action :new_post_limited, only: [:new]

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
    @score = @comments.average(:score)&.round(1) # 口コミの評価平均
  end

  def new
    @post = Post.new
    @code = Code.all
  end

  def edit
    @community = Community.find_by(params[:community_id])
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

    def validate_post
      @post = Post.find(params[:id])
      redirect_to community_post_path(@post.community,@post), alert: "作成ユーザのみ変更操作ができます" if @post.user_id != current_user.id
    end

    def new_post_limited
      @community = Community.find(params[:community_id])
      redirect_to community_path(@community), alert: "所属ユーザのみ新規作成ができます" unless @community.user_belonging?(current_user)
    end

end