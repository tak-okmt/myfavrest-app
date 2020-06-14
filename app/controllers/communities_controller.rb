class CommunitiesController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show]

    def index
        @communities = Community.where(publish_flg: 0)
        @posts = Post.where(community_id: @communities.ids)
        @posts = @posts.page(params[:page])
    end

    def show
        @community = Community.find(params[:id])
        @posts = Post.where(community_id: @community.id)
        @posts = @posts.page(params[:page])
    end

    private

        def community_params
            params.require(:community).permit(:name,:create_user_id,:publish_flg)
        end

end
