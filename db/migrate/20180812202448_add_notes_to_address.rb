class AddNotesToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :notes, :string, null: false, default: ''
    add_index :addresses, :notes
  end
end
