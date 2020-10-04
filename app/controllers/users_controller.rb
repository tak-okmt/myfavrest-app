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
        # 選択したユーザがログインユーザの場合、自ユーザ画面へ遷移
        @belongings = @user.belongings
        @community = Community.find(1) # 誰でもコミュニティ
        @available_communities = Community.where(publish_flg: 0).or(Community.where(id: @user.communities))
        # フォロー中のユーザの投稿を表示（所属していない非公開グループを除く）
        @follow_posts = Post.where(user_id: @user.following_user, community_id: @available_communities).order('updated_at DESC')
        # フォロー中のユーザの口コミを表示
        comments = Comment.where(user_id: @user.following_user).order('updated_at DESC')
        @follow_comments = []
        comments.each do |n| # 口コミがavaliableに含まれるか判定
          @follow_comments << n if n.post.community.in?(@available_communities)
        end
        render template: "users/myusershow"
      else
        # ログインユーザ以外のユーザの場合、ユーザ詳細画面へ遷移
        @comments = @user.comments.order('updated_at DESC')
        @belongings = @user.belongings
      end
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