class ChangeTypeOnDatasheetSuggestions < ActiveRecord::Migration[5.2]
  def change
    remove_column :datasheet_suggestions, :type
    add_column :datasheet_suggestions, :kind, :string, index: true, null: false, default: ''
    DatasheetSuggestion.update_all(kind: 'datasheet')
  end
end
