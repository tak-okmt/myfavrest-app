class RelationshipsController < ApplicationController
    def follow
        current_user.follow(params[:id])
    end
      
    def unfollow
        current_user.unfollow(params[:id])
    end
end
