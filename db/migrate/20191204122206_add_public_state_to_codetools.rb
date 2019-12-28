class AddPublicStateToCodetools < ActiveRecord::Migration[6.0]
  def change
    add_column :codetools, :public, :boolean, default: false
  end
end
