class CreateDatasheetSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :datasheet_suggestions do |t|
      t.string :title
      t.string :link
      t.belongs_to :device, foreign_key: true

      t.timestamps
    end
  end
end
