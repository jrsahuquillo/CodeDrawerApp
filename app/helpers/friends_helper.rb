module FriendsHelper

  def follow_button(friend)
    current_user.followed_back_by?(friend) ? "Follow back" : "Follow"
  end

  def total_favorites(friend)
    friend.total_favorite_codetools
  end
end
