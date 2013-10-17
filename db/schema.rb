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

ActiveRecord::Schema.define(version: 20131016175828) do

  create_table "images", force: true do |t|
    t.integer  "inspection_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "asset"
    t.integer  "imageable_id"
    t.string   "imageable_type"
  end

  add_index "images", ["inspection_id"], name: "index_images_on_inspection_id"
  add_index "images", ["user_id"], name: "index_images_on_user_id"

  create_table "inspected_features", force: true do |t|
    t.string   "name"
    t.string   "condition"
    t.boolean  "clean"
    t.boolean  "marks"
    t.boolean  "damage"
    t.string   "comment"
    t.integer  "inspected_room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inspected_features", ["inspected_room_id"], name: "index_inspected_features_on_inspected_room_id"

  create_table "inspected_rooms", force: true do |t|
    t.string   "name"
    t.integer  "inspection_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "room_type"
  end

  add_index "inspected_rooms", ["inspection_id"], name: "index_inspected_rooms_on_inspection_id"

  create_table "inspections", force: true do |t|
    t.string   "inspection_type"
    t.string   "unit"
    t.string   "tenant"
    t.string   "inspected_by"
    t.datetime "inspection_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "property_id"
    t.integer  "user_id"
  end

  create_table "properties", force: true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "details"
  end

  add_index "properties", ["user_id"], name: "index_properties_on_user_id"

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.integer  "property_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "room_type"
    t.text     "features"
  end

  add_index "rooms", ["property_id"], name: "index_rooms_on_property_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
