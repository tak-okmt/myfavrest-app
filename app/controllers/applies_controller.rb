class AppliesController < ApplicationController
  before_action :authenticate_user!  

  def create
    current_user.applies.create(community_id: apply_params[:community_id])
    redirect_to community_url(apply_params[:community_id]), notice: "加入申請しました"
  end

  def destroy
    @apply = Apply.find(params[:id])
    @apply.destroy!
    @comminity = Community.find(params[:community_id])
    redirect_to community_url(@comminity), notice: "加入申請を取り消しました"
  end

  def index
    @applies = Apply.where(community_id: params[:community_id])
  end

  private

    def apply_params
      params.permit(:community_id)
    end

end
