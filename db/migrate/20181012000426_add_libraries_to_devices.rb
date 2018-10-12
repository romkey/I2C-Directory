class AddLibrariesToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :library, :string
  end
end
