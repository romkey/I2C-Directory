class AddSlugToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :slug, :string, null: false, unique: true, index: true
  end
end
