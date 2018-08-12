class AddObsoleteToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :obsolete, :boolean, null: false, default: false
  end
end
