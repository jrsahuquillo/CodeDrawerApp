class CreatePinCodetools < ActiveRecord::Migration[6.0]
  def change
    create_table :pin_codetools do |t|
      t.integer :user_id
      t.integer :codetool_id
    end
  end
end
