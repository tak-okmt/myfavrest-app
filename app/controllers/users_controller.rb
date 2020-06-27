class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

    def index
      #検索オブジェクト
      @search = User.ransack(params[:q])
      #検索結果
      @users = @search.result
    end

    def show
      @user = User.find(params[:id])
      if @user == current_user
        # 選択したユーザがログインユーザの場合、自ユーザ画面へ遷移
        @belongings = @user.belongings
        @tab = params[:tab_id]
        @community = Community.find(1) # 誰でもコミュニティ
        if params[:tab_id]
          respond_to do |format|
            format.json { render "users/mycom" }  if @tab = '1'
            format.json { render "users/pubcom" } if @tab = '2'
          end
        else
          render template: "users/myusershow"
        end
      else
        # ログインユーザ以外のユーザの場合、ユーザ詳細画面へ遷移
        @comments = @user.comments.order('updated_at DESC')
        @belongings = @user.belongings
      end
    end

end