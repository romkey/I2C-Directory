class AddScannedDriversToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :scanned_drivers, :boolean, null: false, default: false

    add_index :devices, :scanned_drivers
  end
end
