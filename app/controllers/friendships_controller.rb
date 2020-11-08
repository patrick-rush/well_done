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

# from create action
    #is this bulk addition or individual addition?
    # byebug
    # if params.include?(:friend_id) #individual e.g. "Add friend" link
    #   @new_friendships = Friendship.create_reciprocal_for_ids(current_user_id, params[:friend_id])
    # else
    #   params[:user][:friend_ids].each do |f_id|
    #   @new_friendships = Friendship.create_reciprocal_for_ids(current_user_id, f_id)
    #   end
    # end

  # private

  # def friendship_params
  #   params.require(:friendship).permit(:friend_id, :user_id)
  # end
