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

ActiveRecord::Schema.define(version: 20140520193916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", force: true do |t|
    t.string   "street1"
    t.string   "street2"
    t.string   "suite"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
  end

  add_index "addresses", ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type", using: :btree

  create_table "companies", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "email"
    t.string   "phone_number"
  end

  create_table "images", force: true do |t|
    t.integer  "inspection_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "asset"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.text     "comment"
    t.integer  "company_id"
  end

  add_index "images", ["inspection_id"], name: "index_images_on_inspection_id", using: :btree
  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "inspected_features", force: true do |t|
    t.string   "name"
    t.string   "condition"
    t.boolean  "clean"
    t.boolean  "marks"
    t.boolean  "damage"
    t.text     "comment"
    t.integer  "inspected_room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inspected_features", ["inspected_room_id"], name: "index_inspected_features_on_inspected_room_id", using: :btree

  create_table "inspected_rooms", force: true do |t|
    t.string   "name"
    t.integer  "inspection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "room_type"
  end

  add_index "inspected_rooms", ["inspection_id"], name: "index_inspected_rooms_on_inspection_id", using: :btree

  create_table "inspection_details", force: true do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "inspection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
  end

  add_index "inspection_details", ["inspection_id"], name: "index_inspection_details_on_inspection_id", using: :btree

  create_table "inspections", force: true do |t|
    t.string   "inspection_type"
    t.string   "unit"
    t.string   "tenant"
    t.string   "inspected_by"
    t.date     "inspection_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "property_id"
    t.integer  "user_id"
    t.string   "inspection_date_string"
    t.date     "report_date"
    t.text     "details"
    t.string   "name"
    t.integer  "agent_id"
    t.string   "status"
    t.string   "completed_by"
  end

  create_table "payment_methods", force: true do |t|
    t.integer  "user_id"
    t.string   "last_four"
    t.string   "token"
    t.datetime "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cardholder_name"
    t.boolean  "default"
    t.string   "masked_number"
    t.boolean  "is_default"
  end

  add_index "payment_methods", ["user_id"], name: "index_payment_methods_on_user_id", using: :btree

  create_table "plans", force: true do |t|
    t.string   "title"
    t.decimal  "price",                 precision: 8, scale: 2
    t.integer  "inspections_per_month"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "plan_id"
  end

  create_table "properties", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "details"
    t.integer  "legacy_id"
    t.string   "description"
  end

  add_index "properties", ["user_id"], name: "index_properties_on_user_id", using: :btree

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "room_type"
    t.text     "features"
  end

  add_index "rooms", ["property_id"], name: "index_rooms_on_property_id", using: :btree

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "subscription_id"
    t.string   "subscription_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.datetime "next_billing_date"
    t.decimal  "next_billing_period_amount"
    t.string   "payment_method_token"
    t.integer  "plan_id"
  end

  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "account_id"
    t.integer  "legacy_id"
    t.string   "customer_id"
    t.string   "phone_number"
    t.integer  "company_id"
    t.boolean  "admin"
    t.boolean  "agent"
    t.string   "agent_status"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "valuables", force: true do |t|
    t.string   "name"
    t.string   "serial_number"
    t.integer  "value"
    t.integer  "inspection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comments"
  end

  add_index "valuables", ["inspection_id"], name: "index_valuables_on_inspection_id", using: :btree

end
