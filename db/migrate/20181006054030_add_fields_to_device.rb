class AddFieldsToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :release_date, :datetime
    add_column :devices, :is_5v, :boolean
    add_column :devices, :is_3v, :boolean
    add_column :devices, :is_standard_speed, :boolean
    add_column :devices, :is_full_speed, :boolean
    add_column :devices, :is_fast_speed, :boolean
    add_column :devices, :is_high_speed, :boolean
    add_column :devices, :is_ultra_fast_speed, :boolean
    add_column :devices, :is_spi, :boolean
  end
end
