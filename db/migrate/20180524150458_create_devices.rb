class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :part_number
      t.string :friendly_name
      t.tinyint :addresses
      t.string :datasheet
      t.string :adafruit
      t.string :sparkfun
      t.string :amazon

      t.timestamps
    end
  end
end
