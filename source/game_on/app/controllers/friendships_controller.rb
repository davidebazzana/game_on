class FriendshipsController < ApplicationController
    def create
      authorize! :follow, User.find(params[:friend_id])
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
      if @friendship.save
        flash[:notice] = "Following #{User.find(@friendship.friend_id).username}"
        redirect_to root_url
      else
        flash[:error] = "Unable to follow"
        redirect_to root_url
      end
    end
    
    def destroy
      @friendship = current_user.friendships.find(params[:id])
      authorize! :unfollow, @friendship.friend
      @friendship.destroy
      flash[:notice] = "Not following #{User.find(@friendship.friend_id).username} anymore"
      redirect_to current_user
    end

end
