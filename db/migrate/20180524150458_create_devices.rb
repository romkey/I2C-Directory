class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :part_number, null: false, unique: true
      t.string :friendly_name, null: false
      t.string :addresses, null: false, array: true
      t.string :datasheet
      t.string :adafruit
      t.string :sparkfun
      t.string :amazon

      t.integer :views, null: false, default: 0

      t.timestamps
    end
  end
end
