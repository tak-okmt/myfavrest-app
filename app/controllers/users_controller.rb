class UsersController < ApplicationController
  before_action :set_user, only: %i[show follower followed]
  skip_before_action :authenticate_user!, only: %i[index]

    def index
      #検索オブジェクト
      @search = User.ransack(params[:q])
      #検索結果
      @users = @search.result
      @users = @users.page(params[:page]).per(15)
      @code  = Code.all
    end

    def show
      if @user == current_user
        Belonging.create!(community_id: 1, user_id: current_user.id) unless Belonging.find_by(community_id: 1, user_id: current_user.id)
        @available_communities = Community.where(publish_flg: 0).or(Community.where(id: @user.communities))
        # １．フォロー中のユーザの投稿を表示（所属していない非公開グループを除く）
          @follow_posts = Post.where(user_id: @user.following_user, community_id: @available_communities).order('updated_at DESC').page(params[:follow_posts]).per(6)
        # ２．フォロー中のユーザの口コミを表示
          comments = Comment.where(user_id: @user.following_user).order('updated_at DESC')
          @follow_comments = []
          comments.each do |n| # 口コミがavaliableに含まれるか判定
            @follow_comments << n if n.post.community.in?(@available_communities)
          end
          @follow_comments = Kaminari.paginate_array(@follow_comments).page(params[:follow_comments]).per(10)
      end
      @belongings = @user.belongings.page(params[:belong_community]).per(6)
      @comments   = @user.comments.order('updated_at DESC')
      # ３．いいね！した投稿を表示
      @like_posts = @user.likes.order('updated_at DESC').map{ |n| n.post }
      @like_posts = Kaminari.paginate_array(@like_posts).page(params[:like_posts]).per(6)
    end

    def follower
      @users = @user.following_user
    end
  
    def followed
      @users = @user.follower_user
    end

    def set_user
      @user = User.find(params[:id])
    end

end