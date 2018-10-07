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

ActiveRecord::Schema.define(version: 2018_10_07_150713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "address", null: false
    t.string "notes", default: "", null: false
    t.boolean "reserved", default: false, null: false
    t.integer "views", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_addresses_on_address"
    t.index ["notes"], name: "index_addresses_on_notes"
    t.index ["slug"], name: "index_addresses_on_slugs"
    t.index ["views"], name: "index_addresses_on_views"
  end

  create_table "addresses_devices", id: false, force: :cascade do |t|
    t.bigint "address_id", null: false
    t.bigint "device_id", null: false
  end

  create_table "datasheet_suggestions", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.bigint "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_datasheet_suggestions_on_device_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "slug", null: false
    t.string "part_number", null: false
    t.string "friendly_name", null: false
    t.string "manufacturer", default: "", null: false
    t.boolean "obsolete", default: false, null: false
    t.string "attribution"
    t.boolean "suggestion", default: false, null: false
    t.string "datasheet"
    t.string "adafruit"
    t.string "sparkfun"
    t.string "amazon"
    t.integer "views", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "scanned", default: false, null: false
    t.datetime "release_date"
    t.boolean "is_5v", default: false, null: false
    t.boolean "is_3v", default: false, null: false
    t.boolean "is_standard_speed", default: false, null: false
    t.boolean "is_full_speed", default: false, null: false
    t.boolean "is_fast_speed", default: false, null: false
    t.boolean "is_high_speed", default: false, null: false
    t.boolean "is_ultra_fast_speed", default: false, null: false
    t.boolean "is_spi", default: false, null: false
    t.index ["friendly_name"], name: "index_devices_on_friendly_name"
    t.index ["manufacturer"], name: "index_devices_on_manufacturer"
    t.index ["part_number"], name: "index_devices_on_part_number"
    t.index ["scanned"], name: "index_devices_on_scanned"
    t.index ["slug"], name: "index_devices_on_slugs"
    t.index ["suggestion"], name: "index_devices_on_suggestion"
    t.index ["views"], name: "index_devices_on_views"
  end

  create_table "driver_suggestions", force: :cascade do |t|
    t.string "title", null: false
    t.string "link", null: false
    t.bigint "device_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_driver_suggestions_on_device_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "title", null: false
    t.string "link", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "datasheet_suggestions", "devices"
end
