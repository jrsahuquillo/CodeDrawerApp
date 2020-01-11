module FriendsHelper

  def follow_button(friend)
    current_user.followed_back_by?(friend) ? "Follow back" : "Follow"
  end
end
