class AddFieldsToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :release_date, :datetime
    add_column :devices, :is_5v, :boolean, null: false, default: false
    add_column :devices, :is_3v, :boolean, null: false, default: false
    add_column :devices, :is_standard_speed, :boolean, null: false, default: false
    add_column :devices, :is_full_speed, :boolean, null: false, default: false
    add_column :devices, :is_fast_speed, :boolean, null: false, default: false
    add_column :devices, :is_high_speed, :boolean, null: false, default: false
    add_column :devices, :is_ultra_fast_speed, :boolean, null: false, default: false
    add_column :devices, :is_spi, :boolean, null: false, default: false
  end
end
