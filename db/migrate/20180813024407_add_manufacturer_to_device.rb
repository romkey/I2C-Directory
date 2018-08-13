class AddManufacturerToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :manufacturer, :string, null: false, default: ''
    add_index :devices, :manufacturer
  end
end
