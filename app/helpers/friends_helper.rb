module FriendsHelper
  def follows_back?(friend)
    friend.friendships.pluck(:friend_id).include?(current_user.id)
  end

  def follow_button(friend)
    follows_back?(friend) ? "Follow back" : "Follow"
  end
end
