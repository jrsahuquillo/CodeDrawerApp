class AddPositionToCodetools < ActiveRecord::Migration[6.0]
  def change
    add_column :codetools, :position, :integer
  end
end
