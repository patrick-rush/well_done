class FriendshipsController < ApplicationController

  def new
  end

  def create
    Friendship.create_reciprocal_for_ids(current_user.id, params[:friend_id])
    redirect_to users_path
  end

  def destroy
    Friendship.destroy_reciprocal_for_ids(current_user.id, params[:id])
    redirect_to(request.referer)
  end
  
end