class BelongingsController < ApplicationController
    before_action :authenticate_user!

    def create
        @belonging = Belonging.create(community_id: belonging_params[:community_id], user_id: belonging_params[:user_id])
        Apply.find(belonging_params[:apply_id]).destroy!
        redirect_to community_applies_url(@belonging.community), notice:"「#{@belonging.user.username}が、コミュニティ：#{@belonging.community.name}」へ加入しました。"
    end

    private

        def belonging_params
            params.permit(:community_id, :user_id, :apply_id)
        end

end
