class CommunitiesController < ApplicationController
    skip_before_action :authenticate_user!, only: %i[index show]
    before_action :validate_community, only: %i[edit update destroy]

    def index
        #検索オブジェクト
        @search = Community.ransack(params[:q])
        #検索結果
        @communities = @search.result
        @communities = @communities.page(params[:page]).per(12)
    end

    def show
        @community = Community.find(params[:id])
        @belongings = Belonging.where(community_id: @community.id)
        @code = Code.all
        #検索オブジェクト
        @search = Post.ransack(params[:q])
        #検索結果
        @posts = @search.result
        @posts = @posts.where(community_id: @community.id)
        @posts = @posts.page(params[:page]).per(9)
        if current_user
            @belonging = Belonging.find_by(community_id: @community.id, user_id: current_user.id)
            @apply = Apply.find_by(community_id: @community.id, user_id: current_user.id)
        end
    end

    def new
        @community = Community.new
        @code = Code.all
    end

    def edit
        @community = Community.find(params[:id])
        @code = Code.all
    end

    def create
        @community = current_user.communities.build(community_params)
        
        if @community.save
            Belonging.create!(community_id: @community.id, user_id: current_user.id, admin_flg: '1')
            redirect_to communities_url, notice:"グループ「#{@community.name}」を登録しました。"
        else
            render :new
        end
    end

    def update
        community = current_user.communities.find(params[:id])
        community.update!(community_params)
        redirect_to community_url(community), notice:"グループ「#{community.name}」を更新しました。"
    end

    def destroy
        community = Community.find(params[:id])
        community.destroy
        redirect_to communities_url, notice: "グループ「#{community.name}」を削除しました。"
    end

    private

        def community_params
            params.require(:community).permit(:name,:create_user_id,:publish_flg, :description)
        end

        def validate_community
            @community = Community.find(params[:id])
            redirect_to community_path(@community), alert: "作成ユーザのみ変更操作ができます" if @community.create_user_id != current_user.id
        end

end
