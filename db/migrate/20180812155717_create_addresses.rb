class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :address, null: false, unique: true
      t.boolean :reserved, null: false, default: false

      t.timestamps
    end

    add_index :addresses, :address

    create_join_table :addresses, :devices

    add_index :devices, :part_number
    add_index :devices, :friendly_name
    add_index :devices, :views

    remove_column :devices, :addresses, :string, array: true
  end
end
