class AppliesController < ApplicationController
  before_action :authenticate_user!  

  def create
    current_user.applies.create(community_id: apply_params[:community_id])
  end

  def destroy
    @apply = Apply.find(params[:id])
    @apply.destroy!
    @comminity = Community.find(params[:community_id])
  end

  def index
  end

  private

    def apply_params
      params.permit(:community_id)
    end

end
