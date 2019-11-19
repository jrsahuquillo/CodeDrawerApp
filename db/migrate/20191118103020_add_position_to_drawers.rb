class AddPositionToDrawers < ActiveRecord::Migration[6.0]
  def change
    add_column :drawers, :position, :integer
  end
end
