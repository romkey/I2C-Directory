# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_12_202506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "notes", default: "", null: false
    t.index ["address"], name: "index_addresses_on_address"
    t.index ["notes"], name: "index_addresses_on_notes"
  end

  create_table "addresses_devices", id: false, force: :cascade do |t|
    t.bigint "address_id", null: false
    t.bigint "device_id", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "part_number", null: false
    t.string "friendly_name", null: false
    t.boolean "reserved", null: false
    t.string "datasheet"
    t.string "adafruit"
    t.string "sparkfun"
    t.string "amazon"
    t.integer "views", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "obsolete", default: false, null: false
    t.string "attribution"
    t.index ["friendly_name"], name: "index_devices_on_friendly_name"
    t.index ["part_number"], name: "index_devices_on_part_number"
    t.index ["views"], name: "index_devices_on_views"
  end

end
