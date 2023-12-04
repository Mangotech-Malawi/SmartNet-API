# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_04_111359) do
  create_table "custodians", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "custodian_type_id"
    t.string "custodian_type"
    t.boolean "voided", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "phone_number"
    t.string "email"
    t.boolean "voided", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", charset: "utf8mb4", force: :cascade do |t|
    t.string "serial_number"
    t.string "ip_address"
    t.string "name"
    t.string "device_type"
    t.string "mac_address"
    t.boolean "voided", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "custodian_id"
    t.index ["custodian_id"], name: "fk_rails_f7659f1a59"
  end

  create_table "events", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "severity"
    t.boolean "voided", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "intrusions", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "network_event_id"
    t.text "description"
    t.boolean "voided", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["network_event_id"], name: "fk_rails_99ad997a03"
  end

  create_table "network_events", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "device_id"
    t.string "source_ip"
    t.string "dest_ip"
    t.string "protocol"
    t.integer "port"
    t.boolean "voided", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id"
    t.index ["device_id"], name: "fk_rails_123984e701"
    t.index ["event_id"], name: "fk_rails_cd06f04871"
  end

  create_table "people", charset: "utf8mb4", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "gender"
    t.string "date_of_birth"
    t.string "national_id"
    t.string "phone_number"
    t.string "alt_phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "response_actions", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "intrusion_id"
    t.string "action_type"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "voided", default: false, null: false
    t.index ["intrusion_id"], name: "fk_rails_7ea4faf404"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "person_id"
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.string "role"
    t.boolean "voided", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "fk_rails_fa67535741"
  end

  add_foreign_key "devices", "custodians"
  add_foreign_key "intrusions", "network_events"
  add_foreign_key "network_events", "devices"
  add_foreign_key "network_events", "events"
  add_foreign_key "response_actions", "intrusions"
  add_foreign_key "users", "people"
end
