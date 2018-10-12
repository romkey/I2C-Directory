class AddTypeToDatasheetSuggestions < ActiveRecord::Migration[5.2]
  def change
    add_column :datasheet_suggestions, :type, :string, index: true, null: false, default: ''
    DatasheetSuggestion.update_all(type: 'datasheet')
  end
end
