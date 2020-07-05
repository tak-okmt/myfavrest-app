class UsersController < ApplicationController
  before_action :set_user, only: %i[show follower followed]
  skip_before_action :authenticate_user!, only: %i[index show]

    def index
      #検索オブジェクト
      @search = User.ransack(params[:q])
      #検索結果
      @users = @search.result
      @code  = Code.all
    end

    def show
      if @user == current_user
        # 選択したユーザがログインユーザの場合、自ユーザ画面へ遷移
        @belongings = @user.belongings
        @community = Community.find(1) # 誰でもコミュニティ
        @tab = params[:tab_id]
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