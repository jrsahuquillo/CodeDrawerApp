class FriendsController < ApplicationController

  def index
    @friends = Friend.where(user_id: current_user)
  end

  def create
    @friend = Friend.new(user_id: current_user.id, friend_id: params[:friend_id])

    if @friend.save
      flash[:notice] = "You are following to #{@friend.friend.username}"
      redirect_to search_friends_path
    else
      flash[:alert] = "#{@friend.user.username} " + "#{@friend.errors.messages[:friend_id].first}"
      redirect_to search_friends_path
    end
  end

  def destroy
    @friend = Friend.find_by(user_id: current_user.id, friend_id: params[:friend_id])
    if @friend.destroy
        flash[:notice] = "You unfollowed to #{@friend.friend.username}"
        redirect_to search_friends_path
    else
      flash[:aleert] = "#{@friend.user.username} " + "#{@friend.errors.messages[:friend_id].first}"
      redirect_to search_friends_path
    end
  end

  def search_friends
    @searched_friends = params[:search_friends].blank? ? User.all : User.search(params[:search_friends])
  end


end
