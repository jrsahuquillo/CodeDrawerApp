class ChangeFriendsToFriendships < ActiveRecord::Migration[6.0]
  def change
    rename_table :friends, :friendships
  end
end
