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

ActiveRecord::Schema.define(version: 2020_01_25_133448) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "phone_prefix", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "email", default: "", null: false
    t.index ["email"], name: "index_clients_on_email"
    t.index ["first_name", "last_name", "phone_prefix", "phone_number"], name: "client_uniqueness_index", unique: true
    t.index ["last_name"], name: "index_clients_on_last_name"
    t.index ["phone_number"], name: "index_clients_on_phone_number"
    t.index ["phone_prefix"], name: "index_clients_on_phone_prefix"
  end

  create_table "repair_tasks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "repairer_id", null: false
    t.integer "service_order_id", null: false
    t.integer "status", default: 0, null: false
    t.string "currency", null: false
    t.integer "work_cost_cents", default: 0, null: false
    t.integer "materials_cost_cents", default: 0, null: false
    t.index ["repairer_id"], name: "index_repair_tasks_on_repairer_id"
    t.index ["status"], name: "index_repair_tasks_on_status"
  end

  create_table "service_orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "number", default: "", null: false
    t.date "date", null: false
    t.string "location", default: "", null: false
    t.integer "user_id", null: false
    t.integer "client_id", null: false
    t.string "device_name", null: false
    t.string "device_password"
    t.boolean "device_warranty", default: false, null: false
    t.text "device_extras", default: "", null: false
    t.text "device_saveable_info", default: "", null: false
    t.text "device_defect", default: "", null: false
    t.text "device_additional_info", default: "", null: false
    t.index ["client_id"], name: "index_service_orders_on_client_id"
    t.index ["date"], name: "index_service_orders_on_date"
    t.index ["device_name"], name: "index_service_orders_on_device_name"
    t.index ["location"], name: "index_service_orders_on_location"
    t.index ["number"], name: "index_service_orders_on_number"
    t.index ["user_id"], name: "index_service_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
