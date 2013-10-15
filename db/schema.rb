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

ActiveRecord::Schema.define(version: 20131015042719) do

  create_table "chars", force: true do |t|
    t.string   "name",         limit: 20
    t.string   "pass",                                null: false
    t.datetime "last_seen_at",                        null: false
    t.integer  "x",                                   null: false
    t.integer  "y",                                   null: false
    t.integer  "z",                       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chars", ["name"], name: "index_chars_on_name", unique: true, using: :btree
  add_index "chars", ["x", "y", "z"], name: "index_chars_on_x_and_y_and_z", using: :btree

end
