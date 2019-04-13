class AddViewsToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :views, :integer, null: false, default: 0
    add_index :addresses, :views
  end
end
