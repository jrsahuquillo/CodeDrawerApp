class FriendshipsController < ApplicationController

  def index
    @friends = Friendship.where(user_id: current_user)
    @public_codetools = current_user.friends.map{|friend| friend.codetools.where(public: true)}.flatten
  end

  def create
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id])
    @friend = @friendship.friend
    if @friendship.save
      # Create notification
      Notification.create(recipient: @friend, actor: current_user, action: "is following", notifiable: @friendship )
      flash[:notice] = "You are following to #{@friend.username}"
    else
      flash[:alert] = "#{@friend.username} " + "#{@friend.errors.messages[:friend_id].first}"
    end
    redirect_to search_friends_path
  end

  def destroy
    @friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:friend_id])
    @friend = @friendship.friend
    if @friendship.destroy
      flash[:notice] = "You unfollowed #{@friend.username}"
    else
      flash[:alert] = "#{@friend.username} " + "#{@friendship.errors.messages[:friend_id].first}"
    end
    redirect_to search_friends_path
  end

  def search_friends
    @searched_friends = params[:search_friends].blank? ? User.all : User.search(params[:search_friends])
  end

end
