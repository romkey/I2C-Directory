class DriverSuggestions < ActiveRecord::Migration[5.2]
  def change
    create_table :driver_suggestions do |t|
      t.string "title", null: false
      t.string "link", null: false
      t.bigint "device_id", null: false

      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false

      t.index ["device_id"], name: "index_driver_suggestions_on_device_id"
    end
  end
end
