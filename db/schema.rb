# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150222223225) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "codes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "pin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "codes", ["user_id"], name: "index_codes_on_user_id", using: :btree

  create_table "destinations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "phone"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "destinations", ["user_id"], name: "index_destinations_on_user_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.integer  "user_id"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "day_of_week"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_inbound"
    t.string   "plan_name"
    t.string   "dtmf"
    t.string   "timezone"
    t.string   "country_code"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visitors", force: :cascade do |t|
    t.string   "phone"
    t.string   "country_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "codes", "users"
  add_foreign_key "destinations", "users"
  add_foreign_key "schedules", "users"
end
