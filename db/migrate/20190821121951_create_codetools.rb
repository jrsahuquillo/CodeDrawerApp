class CreateCodetools < ActiveRecord::Migration[6.0]
  def change
    create_table :codetools do |t|
      t.string :title
      t.text :content
      t.references :drawer, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
