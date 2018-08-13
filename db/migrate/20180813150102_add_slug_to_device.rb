class AddSlugToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :slug, :string, null: false, unique: true, index: true
  end
end
