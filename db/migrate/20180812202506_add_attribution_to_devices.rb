class AddAttributionToDevices < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :attribution, :string
  end
end
