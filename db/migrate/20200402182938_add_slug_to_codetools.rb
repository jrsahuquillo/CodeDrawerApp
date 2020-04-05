class AddSlugToCodetools < ActiveRecord::Migration[6.0]
  def change
    add_column :codetools, :slug, :string
  end
end
