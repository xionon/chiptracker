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

ActiveRecord::Schema.define(version: 20160219015329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bowls", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "chips"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bowls", ["person_id"], name: "index_bowls_on_person_id", using: :btree

  create_table "households", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.integer  "household_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "people", ["household_id"], name: "index_people_on_household_id", using: :btree

  add_foreign_key "bowls", "people"
  add_foreign_key "people", "households"
end
