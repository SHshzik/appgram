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

ActiveRecord::Schema.define(version: 20200217161753) do

  create_table "messages", force: :cascade do |t|
    t.text     "msg"
    t.boolean  "status",     default: false
    t.integer  "sender_id"
    t.integer  "room_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.index ["room_id", "user_id"], name: "index_rooms_users_on_room_id_and_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "phone"
    t.string   "email"
    t.string   "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
