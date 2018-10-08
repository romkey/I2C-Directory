class ChangeObsoleteInDevices < ActiveRecord::Migration[5.2]
  def change
    change_column :devices, :obsolete, :boolean, null: true, default: nil
  end
end
