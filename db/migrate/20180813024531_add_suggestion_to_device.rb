class AddSuggestionToDevice < ActiveRecord::Migration[5.2]
  def change
    add_column :devices, :suggestion, :boolean, null: false, default: false
    add_index :devices, :suggestion
  end
end
