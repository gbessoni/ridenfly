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

ActiveRecord::Schema.define(version: 20141106070422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "companies", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "contact_first_name"
    t.string   "contact_last_name"
    t.string   "street"
    t.string   "state"
    t.string   "zipcode"
    t.string   "phone"
    t.string   "mobile"
    t.string   "dispatch_phone"
    t.string   "website"
    t.text     "description"
    t.hstore   "reservation_notification"
    t.text     "blackout_dates"
    t.text     "airports"
    t.string   "hours_of_operation"
    t.string   "hours_in_advance_to_accept_rez"
    t.text     "pickup_info"
    t.text     "after_hours_info"
    t.string   "excess_luggage_charge"
    t.boolean  "luggage_insured",                default: false
    t.string   "child_rate"
    t.boolean  "child_car_seats_included",       default: false
    t.text     "luggage_limitation_policy"
    t.text     "company_reservation_policy"
    t.text     "company_cancellation_policy"
    t.text     "child_safety_policy"
    t.text     "pet_car_seat_policy"
    t.text     "other_vehicle_types"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "vehicle_types",                                  array: true
    t.string   "fax"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "roles",                  default: "[]"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "companies", "users", name: "companies_user_id_fk", dependent: :delete

end
