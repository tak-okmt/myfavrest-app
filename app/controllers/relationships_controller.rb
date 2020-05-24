class RelationshipsController < ApplicationController
    before_action :authenticate_user!

    def create
        current_user.follow(params[:id])
        @user = User.find(params[:id])
    end
      
    def destroy
        current_user.unfollow(params[:id])
        @user = User.find(params[:id])
    end

    private
        def user_params
            params.permit(:id)
        end

end
