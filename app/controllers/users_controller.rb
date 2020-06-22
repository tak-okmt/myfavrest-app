class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  
    def show
      @user = User.find(params[:id])
      @comments = @user.comments.order('updated_at DESC')
      @belongings = @user.belongings
    end

end