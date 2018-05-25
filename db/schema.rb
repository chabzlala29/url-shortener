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

ActiveRecord::Schema.define(version: 2018_05_25_090256) do

  create_table "url_infos", force: :cascade do |t|
    t.string "ip"
    t.string "city"
    t.string "region"
    t.string "country"
    t.string "loc"
    t.string "postal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "url_id"
    t.datetime "last_visited_at"
    t.string "device_name"
    t.string "browser"
    t.index ["url_id"], name: "index_url_infos_on_url_id"
  end

  create_table "urls", force: :cascade do |t|
    t.string "original_url"
    t.string "shorten_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slugified_url"
    t.bigint "visits"
  end

end
