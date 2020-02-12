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

ActiveRecord::Schema.define(version: 20200212044543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"

  create_table "airports", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "street_address", limit: 255
    t.string   "city",           limit: 255
    t.string   "state",          limit: 2
    t.string   "zipcode",        limit: 5
    t.string   "code",           limit: 3
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "timezone"
    t.datetime "deleted_at"
  end

  add_index "airports", ["deleted_at"], name: "index_airports_on_deleted_at", using: :btree
  add_index "airports", ["name"], name: "index_airports_on_name", unique: true, using: :btree
  add_index "airports", ["state", "code"], name: "index_airports_on_state_and_code", unique: true, using: :btree

  create_table "companies", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",                           limit: 255
    t.string   "contact_first_name",             limit: 255
    t.string   "contact_last_name",              limit: 255
    t.string   "street",                         limit: 255
    t.string   "state",                          limit: 255
    t.string   "zipcode",                        limit: 255
    t.string   "phone",                          limit: 255
    t.string   "mobile",                         limit: 255
    t.string   "dispatch_phone",                 limit: 255
    t.string   "website",                        limit: 255
    t.text     "description"
    t.hstore   "reservation_notification"
    t.text     "blackout_dates"
    t.text     "airports"
    t.string   "hours_of_operation",             limit: 255
    t.string   "hours_in_advance_to_accept_rez", limit: 255
    t.text     "pickup_info"
    t.text     "after_hours_info"
    t.string   "excess_luggage_charge",          limit: 255
    t.boolean  "luggage_insured",                                                    default: false
    t.string   "child_rate",                     limit: 255
    t.boolean  "child_car_seats_included",                                           default: false
    t.text     "luggage_limitation_policy"
    t.text     "company_reservation_policy"
    t.text     "company_cancellation_policy"
    t.text     "child_safety_policy"
    t.text     "pet_car_seat_policy"
    t.text     "other_vehicle_types"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.hstore   "vehicle_types",                                                                      array: true
    t.string   "fax",                            limit: 255
    t.string   "city",                           limit: 255
    t.boolean  "active",                                                             default: true
    t.string   "image_file_name",                limit: 255
    t.string   "image_content_type",             limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "no_pickup_message"
    t.boolean  "active_to_airport",                                                  default: true
    t.boolean  "active_from_airport",                                                default: true
    t.decimal  "commission",                                 precision: 8, scale: 2, default: 0.0
    t.string   "payment_type"
    t.decimal  "airport_pickup_fee",                         precision: 8, scale: 2, default: 0.0
    t.string   "confirmation_emails"
    t.datetime "deleted_at"
  end

  add_index "companies", ["deleted_at"], name: "index_companies_on_deleted_at", using: :btree
  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "company_vehicle_types", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "name"
    t.string   "how_many"
    t.integer  "num_of_passengers"
    t.datetime "deleted_at"
  end

  add_index "company_vehicle_types", ["company_id"], name: "index_company_vehicle_types_on_company_id", using: :btree
  add_index "company_vehicle_types", ["deleted_at"], name: "index_company_vehicle_types_on_deleted_at", using: :btree
  add_index "company_vehicle_types", ["num_of_passengers"], name: "index_company_vehicle_types_on_num_of_passengers", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id",             null: false
    t.integer  "application_id",                null: false
    t.string   "token",             limit: 255, null: false
    t.integer  "expires_in",                    null: false
    t.text     "redirect_uri",                  null: false
    t.datetime "created_at",                    null: false
    t.datetime "revoked_at"
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             limit: 255, null: false
    t.string   "refresh_token",     limit: 255
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                    null: false
    t.string   "scopes",            limit: 255
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",         limit: 255, null: false
    t.string   "uid",          limit: 255, null: false
    t.string   "secret",       limit: 255, null: false
    t.text     "redirect_uri",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
    t.string   "owner_type",   limit: 255
  end

  add_index "oauth_applications", ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type", using: :btree
  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "company_id"
    t.datetime "from"
    t.datetime "to"
    t.decimal  "amount",         precision: 8, scale: 2
    t.boolean  "paid",                                   default: false
    t.decimal  "net_commission", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "payments", ["company_id"], name: "index_payments_on_company_id", using: :btree
  add_index "payments", ["deleted_at"], name: "index_payments_on_deleted_at", using: :btree
  add_index "payments", ["from"], name: "index_payments_on_from", using: :btree
  add_index "payments", ["to"], name: "index_payments_on_to", using: :btree

  create_table "rate_pickup_times", force: :cascade do |t|
    t.integer "pickup"
    t.integer "rate_id"
    t.string  "direction", default: "to_airport"
  end

  add_index "rate_pickup_times", ["rate_id", "direction"], name: "index_rate_pickup_times_on_rate_id_and_direction", using: :btree

  create_table "rates", force: :cascade do |t|
    t.integer  "airport_id"
    t.string   "vehicle_type_passenger",   limit: 255
    t.string   "service_type",             limit: 255
    t.decimal  "base_rate",                            precision: 8, scale: 2
    t.decimal  "additional_passenger",                 precision: 8, scale: 2, default: 0.0
    t.string   "zipcode",                  limit: 255
    t.string   "hotel_landmark_name",      limit: 255
    t.string   "hotel_landmark_street",    limit: 255
    t.string   "hotel_landmark_city",      limit: 255
    t.string   "hotel_landmark_state",     limit: 255
    t.integer  "trip_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.float    "lat"
    t.float    "lng"
    t.string   "hl_words",                 limit: 255
    t.boolean  "hotel_by_zipcode",                                             default: false
    t.integer  "vehicle_capacity_type_id"
    t.datetime "deleted_at"
  end

  add_index "rates", ["airport_id"], name: "index_rates_on_airport_id", using: :btree
  add_index "rates", ["company_id"], name: "index_rates_on_company_id", using: :btree
  add_index "rates", ["deleted_at"], name: "index_rates_on_deleted_at", using: :btree
  add_index "rates", ["hl_words"], name: "index_rates_on_hl_words", using: :btree
  add_index "rates", ["vehicle_capacity_type_id"], name: "index_rates_on_vehicle_capacity_type_id", using: :btree
  add_index "rates", ["vehicle_type_passenger"], name: "index_rates_on_vehicle_type_passenger", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.datetime "flight_datetime"
    t.datetime "pickup_datetime"
    t.string   "passenger_name",     limit: 255
    t.string   "phone",              limit: 255
    t.integer  "adults"
    t.decimal  "net_fare",                       precision: 8, scale: 2
    t.decimal  "gratuity",                       precision: 8, scale: 2, default: 0.0
    t.string   "address",            limit: 255
    t.string   "cross_street",       limit: 255
    t.string   "airline",            limit: 255
    t.integer  "luggage",                                                default: 0
    t.string   "cancelation_reason", limit: 255
    t.string   "flight_number",      limit: 255
    t.string   "status",             limit: 255,                         default: "active"
    t.string   "trip_direction",     limit: 255,                         default: "to_airport"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sibling_id"
    t.integer  "rate_id"
    t.integer  "children",                                               default: 0
    t.string   "email",              limit: 255
    t.string   "flight_type",        limit: 255,                         default: "domestic"
    t.string   "additional_notes"
    t.string   "sub_status"
    t.string   "notes"
    t.datetime "deleted_at"
  end

  add_index "reservations", ["created_at"], name: "index_reservations_on_created_at", order: {"created_at"=>:desc}, using: :btree
  add_index "reservations", ["deleted_at"], name: "index_reservations_on_deleted_at", using: :btree
  add_index "reservations", ["pickup_datetime"], name: "index_reservations_on_pickup_datetime", using: :btree
  add_index "reservations", ["rate_id"], name: "index_reservations_on_rate_id", using: :btree
  add_index "reservations", ["sibling_id"], name: "index_reservations_on_sibling_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",   null: false
    t.string   "encrypted_password",     limit: 255, default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "roles",                  limit: 255, default: "[]"
    t.datetime "deleted_at"
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

