class CreateResources < ActiveRecord::Migration[5.2]
  def change
    create_table :resources do |t|
      t.string :title, null: false
      t.string :link, null: false

      t.timestamps
    end
  end
end
