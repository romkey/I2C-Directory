class AddDriversToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :drivers, :jsonb, null: false, default: []
    remove_column :devices, :library, :string
  end
end
