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

ActiveRecord::Schema.define(version: 20141124120835) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "airports", force: true do |t|
    t.string   "name"
    t.string   "street_address"
    t.string   "city"
    t.string   "state",          limit: 2
    t.string   "zipcode",        limit: 5
    t.string   "code",           limit: 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "airports", ["name"], name: "index_airports_on_name", unique: true, using: :btree
  add_index "airports", ["state", "code"], name: "index_airports_on_state_and_code", unique: true, using: :btree

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

  create_table "oauth_access_grants", force: true do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: true do |t|
    t.string   "name",         null: false
    t.string   "uid",          null: false
    t.string   "secret",       null: false
    t.text     "redirect_uri", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type"
  end

  add_index "oauth_applications", ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type", using: :btree
  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "rate_pickup_times", force: true do |t|
    t.integer "pickup"
    t.integer "rate_id"
  end

  create_table "rates", force: true do |t|
    t.integer  "airport_id"
    t.string   "vehicle_type_passenger"
    t.string   "service_type"
    t.decimal  "base_rate",              precision: 8, scale: 2
    t.decimal  "additional_passenger",   precision: 8, scale: 2, default: 0.0
    t.string   "zipcode"
    t.string   "hotel_landmark_name"
    t.string   "hotel_landmark_street"
    t.string   "hotel_landmark_city"
    t.string   "hotel_landmark_state"
    t.integer  "trip_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "reservations", force: true do |t|
    t.integer  "airport_id"
    t.integer  "company_id"
    t.datetime "flight_datetime"
    t.datetime "pickup_datetime"
    t.string   "passenger_name"
    t.string   "phone"
    t.integer  "num_of_passengers"
    t.decimal  "net_fare",           precision: 8, scale: 2
    t.decimal  "gratuity",           precision: 8, scale: 2, default: 0.0
    t.string   "addresss"
    t.string   "cross_street"
    t.string   "airline"
    t.integer  "luggage",                                    default: 0
    t.string   "cancelation_reason"
    t.string   "flight_number"
    t.string   "status",                                     default: "created"
    t.string   "service_type",                               default: "to_airport"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  add_foreign_key "rate_pickup_times", "rates", name: "rate_pickup_times_rate_id_fk", dependent: :delete

  add_foreign_key "rates", "airports", name: "rates_airport_id_fk", dependent: :delete
  add_foreign_key "rates", "companies", name: "rates_company_id_fk", dependent: :delete

  add_foreign_key "reservations", "airports", name: "reservations_airport_id_fk", dependent: :delete
  add_foreign_key "reservations", "companies", name: "reservations_company_id_fk", dependent: :delete

end
