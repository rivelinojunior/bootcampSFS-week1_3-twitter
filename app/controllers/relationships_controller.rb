class RelationshipsController < ApplicationController

    def create
        user = User.find(params[:following_id])
        current_user.follow(user)
        redirect_to(:back)
    end

    def destroy
        user = User.find(params[:id])
        current_user.unfollow(user)
        redirect_to(:back)
    end
end