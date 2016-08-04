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

ActiveRecord::Schema.define(version: 20160804150516) do

  create_table "abilities", force: :cascade do |t|
    t.string   "unique_id"
    t.text     "use_counts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "android_packages", force: :cascade do |t|
    t.string   "version"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identify_callings", force: :cascade do |t|
    t.string   "request_id"
    t.string   "remote_ip"
    t.string   "device_id"
    t.string   "id_number"
    t.string   "name"
    t.integer  "image_id"
    t.text     "sensetime_result"
    t.datetime "created_at"
    t.string   "endpoint"
    t.string   "validity"
    t.integer  "city_id"
    t.index ["image_id"], name: "index_identify_callings_on_image_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "sensetime_image_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "category"
    t.string   "thumbnail_url"
    t.string   "thumbnail_image_file_name"
    t.string   "thumbnail_image_content_type"
    t.integer  "thumbnail_image_file_size"
    t.datetime "thumbnail_image_updated_at"
    t.string   "source_url"
    t.text     "source_content"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "people", force: :cascade do |t|
    t.string   "id_number"
    t.string   "name"
    t.integer  "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_people_on_image_id"
  end

end
