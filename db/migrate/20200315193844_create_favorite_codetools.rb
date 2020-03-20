class CreateFavoriteCodetools < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_codetools do |t|
      t.integer :user_id
      t.integer :codetool_id

      t.timestamps
    end
  end
end
