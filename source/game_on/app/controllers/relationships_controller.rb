class RelationshipsController < ApplicationController
    def create
      @followed = User.find(params[:followed_id])
      authorize! :follow, @followed
      @relationship = current_user.following_relationships.build(:followed_id => params[:followed_id])
      if @relationship.save
        flash[:notice] = "Following #{@followed.username}"
        redirect_to root_url
      else
        flash[:error] = "Unable to follow"
        redirect_to root_url
      end
    end
    
    def destroy
      @relationship = current_user.following_relationships.find_by(followed_id: params[:id])
      authorize! :unfollow, @relationship.followed
      @relationship.destroy
      flash[:notice] = "Not following #{User.find(@relationship.followed_id).username} anymore"
      redirect_to current_user
    end

end
