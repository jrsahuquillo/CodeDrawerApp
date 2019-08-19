class AddUserToDrawers < ActiveRecord::Migration[6.0]
  def change
    add_reference :drawers, :user, foreign_key: true
  end
end
