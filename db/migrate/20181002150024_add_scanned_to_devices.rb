class AddScannedToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :scanned, :boolean, null: false, default: false

    add_index :devices, :scanned
  end
end
