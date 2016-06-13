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

ActiveRecord::Schema.define(version: 20160613175923) do

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.string   "front_cover"
    t.string   "style"
    t.string   "avatar"
    t.integer  "max_page"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
    t.string   "orientation"
    t.integer  "photo_per_page"
    t.string   "album_layout"
    t.string   "description"
    t.boolean  "has_memo"
    t.integer  "number_in_stock"
    t.float    "price"
  end

  add_index "albums", ["orientation"], name: "index_albums_on_orientation"
  add_index "albums", ["photo_per_page"], name: "index_albums_on_photo_per_page"
  add_index "albums", ["user_id"], name: "index_albums_on_user_id"

  create_table "diaries", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "diaries", ["user_id"], name: "index_diaries_on_user_id"

  create_table "freephotos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
    t.integer  "album_id"
  end

  add_index "freephotos", ["album_id"], name: "index_freephotos_on_album_id"

  create_table "photos", force: :cascade do |t|
    t.string   "memo"
    t.string   "picture"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "album_id"
    t.integer  "photo_number"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id"
  add_index "photos", ["photo_number"], name: "index_photos_on_photo_number"

  create_table "sample_albums", force: :cascade do |t|
    t.string   "name"
    t.string   "avatar"
    t.integer  "max_page"
    t.string   "orientation"
    t.integer  "photo_per_page"
    t.string   "album_layout"
    t.string   "description"
    t.boolean  "has_memo"
    t.integer  "number_in_stock"
    t.float    "price"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
