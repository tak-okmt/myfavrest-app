class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :validate_post, only: %i[edit update destroy]
  before_action :new_post_limited, only: [:new]
  before_action :set_community

  def show
    @post = Post.find(params[:id])
    @pref_name = set_pref_name
    @comments = @post.comments
    @comments = set_comment_order(@comments, params[:comment_order])
    @score = @comments.average(:score)&.round(1) # 口コミの評価平均
  end

  def new
    @post = Post.new
    @code = Code.all
  end

  def edit
    @post = @community.posts.find(params[:id])
    @code = Code.all
  end

  def create
    @post = @community.posts.build(post_params)
    @code = Code.all

    if @post.save
      redirect_to community_url(@community), notice: "お店「#{@post.title}」を登録しました。"
    else
      render :new
    end
  end

  def update
    post = @community.posts.find(params[:id])
    post.update!(post_params)
    redirect_to community_url(@community), notice: "お店「#{post.title}」を更新しました。"
  end

  def destroy
    post = @community.posts.find(params[:id])
    post.destroy!
    redirect_to community_url(@community), notice: "お店「#{post.title}」を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image, :area, :prefecture_code, :rest_type, :address).merge(user_id: current_user.id)
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
    return unless @post.user_id != current_user.id

    redirect_to community_post_path(@post.community, @post), alert: "作成ユーザのみ変更操作ができます"
  end

  def new_post_limited
    @community = Community.find(params[:community_id])
    redirect_to community_path(@community), alert: "所属ユーザのみ新規作成ができます" unless @community.user_belonging?(current_user)
  end

  def set_community
    @community = Community.find(params[:community_id])
  end

  def set_pref_name
    @post.prefecture_code.present? ? @post.prefecture.name : ""
  end
end
