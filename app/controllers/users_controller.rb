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
      @comments = @user.comments.order('updated_at DESC')
      @belongings = @user.belongings
    end

end