class AddSlugToDrawers < ActiveRecord::Migration[6.0]
  def change
    add_column :drawers, :slug, :string
  end
end
