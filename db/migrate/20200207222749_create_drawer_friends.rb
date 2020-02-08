class CreateDrawerFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :drawer_friends do |t|
      t.integer :drawer_id
      t.integer :friend_id

      t.timestamps
    end
  end
end
