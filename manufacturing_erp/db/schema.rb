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

ActiveRecord::Schema[8.0].define(version: 2025_11_30_020444) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.bigint "production_line_id", null: false
    t.bigint "equipment_id", null: false
    t.string "alert_type"
    t.string "severity"
    t.text "message"
    t.string "status"
    t.datetime "triggered_at"
    t.datetime "resolved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_alerts_on_equipment_id"
    t.index ["production_line_id"], name: "index_alerts_on_production_line_id"
  end

  create_table "equipment", force: :cascade do |t|
    t.string "name"
    t.string "serial_number"
    t.bigint "production_line_id", null: false
    t.string "status"
    t.datetime "last_maintenance"
    t.datetime "next_maintenance"
    t.integer "operating_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["production_line_id"], name: "index_equipment_on_production_line_id"
  end

  create_table "maintenance_schedules", force: :cascade do |t|
    t.bigint "equipment_id", null: false
    t.datetime "scheduled_date"
    t.string "maintenance_type"
    t.text "description"
    t.string "status"
    t.datetime "completed_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_maintenance_schedules_on_equipment_id"
  end

  create_table "production_lines", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.integer "capacity"
    t.integer "current_output"
    t.decimal "efficiency"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quality_checks", force: :cascade do |t|
    t.bigint "production_line_id", null: false
    t.bigint "equipment_id", null: false
    t.string "check_type"
    t.string "result"
    t.string "severity"
    t.datetime "performed_at"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_quality_checks_on_equipment_id"
    t.index ["production_line_id"], name: "index_quality_checks_on_production_line_id"
  end

  create_table "sensor_data", force: :cascade do |t|
    t.bigint "equipment_id", null: false
    t.bigint "production_line_id", null: false
    t.string "metric_type"
    t.decimal "value"
    t.string "unit"
    t.datetime "recorded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["equipment_id"], name: "index_sensor_data_on_equipment_id"
    t.index ["production_line_id"], name: "index_sensor_data_on_production_line_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "alerts", "equipment"
  add_foreign_key "alerts", "production_lines"
  add_foreign_key "equipment", "production_lines"
  add_foreign_key "maintenance_schedules", "equipment"
  add_foreign_key "quality_checks", "equipment"
  add_foreign_key "quality_checks", "production_lines"
  add_foreign_key "sensor_data", "equipment"
  add_foreign_key "sensor_data", "production_lines"
end
