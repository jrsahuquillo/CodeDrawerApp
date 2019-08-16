class RenameCasesToDrawers < ActiveRecord::Migration[6.0]
  def change
    rename_table :cases, :drawers
  end
end
