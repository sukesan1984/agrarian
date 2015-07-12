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

ActiveRecord::Schema.define(version: 20150712045645) do

  create_table "area_nodes", force: :cascade do |t|
    t.integer  "area_id",    limit: 4
    t.integer  "node_point", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "area_nodes", ["area_id"], name: "index_area_nodes_on_area_id", using: :btree

  create_table "areas", force: :cascade do |t|
    t.integer  "area_type",  limit: 4
    t.integer  "type_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "enemies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "attack",     limit: 4
    t.integer  "defense",    limit: 4
    t.integer  "hp",         limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "harvests", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "description",  limit: 255
    t.integer  "item_type",    limit: 4
    t.integer  "item_type_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "nature_fields", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "harvest_id",  limit: 4
    t.integer  "resource_id", limit: 4
  end

  create_table "players", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "hp",         limit: 4,   default: 50
    t.integer  "hp_max",     limit: 4,   default: 50
  end

  add_index "players", ["user_id"], name: "index_players_on_user_id", unique: true, using: :btree

  create_table "resource_keepers", force: :cascade do |t|
    t.integer  "target_id",         limit: 4
    t.integer  "current_count",     limit: 4
    t.datetime "last_recovered_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "resource_keepers", ["target_id"], name: "index_resource_keepers_on_target_id", unique: true, using: :btree

  create_table "resources", force: :cascade do |t|
    t.integer  "recover_count",    limit: 4
    t.integer  "recover_interval", limit: 4
    t.integer  "max_count",        limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "roads", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "road_length", limit: 4
  end

  create_table "routes", force: :cascade do |t|
    t.integer  "area_node_id",           limit: 4
    t.integer  "connected_area_node_id", limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "routes", ["area_node_id"], name: "index_routes_on_area_node_id", using: :btree

  create_table "town_bulletin_boards", force: :cascade do |t|
    t.integer  "town_id",    limit: 4
    t.integer  "player_id",  limit: 4
    t.string   "contents",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "town_bulletin_boards", ["town_id"], name: "index_town_bulletin_boards_on_town_id", using: :btree

  create_table "towns", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_areas", primary_key: "player_id", force: :cascade do |t|
    t.integer  "area_node_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_items", force: :cascade do |t|
    t.integer  "player_id",  limit: 4
    t.integer  "item_id",    limit: 4
    t.integer  "count",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
