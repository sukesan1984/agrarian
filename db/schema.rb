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

ActiveRecord::Schema.define(version: 20150923051850) do

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
    t.integer  "enemy_rate", limit: 4
    t.integer  "enemy_num",  limit: 4
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "consumptions", force: :cascade do |t|
    t.integer  "item_id",          limit: 4
    t.integer  "consumption_type", limit: 4
    t.integer  "type_value",       limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "consumptions", ["item_id"], name: "index_consumptions_on_item_id", unique: true, using: :btree

  create_table "dungeons", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "enemies", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.integer  "attack",                limit: 4
    t.integer  "defense",               limit: 4
    t.integer  "hp",                    limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "description",           limit: 255
    t.integer  "rails",                 limit: 4
    t.integer  "exp",                   limit: 4
    t.integer  "item_lottery_group_id", limit: 4,   default: 0, null: false
    t.integer  "drop_item_rate",        limit: 4,   default: 0, null: false
    t.integer  "critical_hit_chance",   limit: 4,   default: 0, null: false
    t.integer  "critical_hit_damage",   limit: 4,   default: 0, null: false
    t.integer  "dodge_chance",          limit: 4,   default: 0, null: false
    t.integer  "damage_reduction",      limit: 4,   default: 0, null: false
    t.integer  "item_rarity",           limit: 4
  end

  create_table "enemy_maps", force: :cascade do |t|
    t.integer  "area_id",    limit: 4
    t.integer  "enemy_id",   limit: 4
    t.integer  "weight",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "enemy_maps", ["area_id"], name: "index_enemy_maps_on_area_id", using: :btree

  create_table "equipment", force: :cascade do |t|
    t.integer  "item_id",             limit: 4
    t.integer  "body_region",         limit: 4
    t.integer  "attack",              limit: 4
    t.integer  "defense",             limit: 4
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "critical_hit_chance", limit: 4, default: 0, null: false
    t.integer  "critical_hit_damage", limit: 4, default: 0, null: false
    t.integer  "dodge_chance",        limit: 4, default: 0, null: false
    t.integer  "damage_reduction",    limit: 4, default: 0, null: false
  end

  create_table "equipment_affixes", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.integer  "equipment_type",         limit: 4
    t.integer  "affix_group",            limit: 4
    t.integer  "affix_type",             limit: 4
    t.integer  "rarity",                 limit: 4
    t.integer  "damage_perc_min",        limit: 4
    t.integer  "damage_perc_max",        limit: 4
    t.integer  "attack_rating_perc_min", limit: 4
    t.integer  "attack_rating_perc_max", limit: 4
    t.integer  "defense_perc_min",       limit: 4
    t.integer  "defense_perc_max",       limit: 4
    t.integer  "hp_min",                 limit: 4
    t.integer  "hp_max",                 limit: 4
    t.integer  "hp_steal_perc_min",      limit: 4
    t.integer  "hp_steal_perc_max",      limit: 4
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "establishments", force: :cascade do |t|
    t.integer  "town_id",            limit: 4
    t.integer  "establishment_type", limit: 4
    t.integer  "establishment_id",   limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "gifts", force: :cascade do |t|
    t.integer  "item_id",    limit: 4
    t.integer  "count",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "harvests", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "description",     limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "item_ability_id", limit: 4
  end

  create_table "inns", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "rails",       limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "item_abilities", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "item_ability_lists", force: :cascade do |t|
    t.integer  "item_id",         limit: 4
    t.integer  "item_ability_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "item_lotteries", force: :cascade do |t|
    t.integer  "group_id",           limit: 4
    t.integer  "item_id",            limit: 4
    t.integer  "count",              limit: 4
    t.integer  "weight",             limit: 4
    t.integer  "composite_group_id", limit: 4, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "description",    limit: 255
    t.integer  "item_type",      limit: 4
    t.integer  "item_type_id",   limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "purchase_price", limit: 4
    t.integer  "sell_price",     limit: 4
  end

  create_table "levels", force: :cascade do |t|
    t.integer  "exp_min",    limit: 4
    t.integer  "exp_max",    limit: 4
    t.integer  "level",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "levels", ["level"], name: "index_levels_on_level", using: :btree

  create_table "nature_fields", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "description",        limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "resource_action_id", limit: 4
    t.integer  "resource_id",        limit: 4
  end

  create_table "players", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "hp",         limit: 4,   default: 50
    t.integer  "hp_max",     limit: 4,   default: 50
    t.integer  "rails",      limit: 4,   default: 300
    t.integer  "str",        limit: 4,   default: 2,   null: false
    t.integer  "dex",        limit: 4,   default: 5,   null: false
    t.integer  "vit",        limit: 4,   default: 3,   null: false
    t.integer  "ene",        limit: 4,   default: 5,   null: false
  end

  add_index "players", ["user_id"], name: "index_players_on_user_id", unique: true, using: :btree

  create_table "quest_conditions", force: :cascade do |t|
    t.integer  "quest_id",        limit: 4
    t.integer  "target",          limit: 4
    t.integer  "condition_type",  limit: 4
    t.integer  "condition_id",    limit: 4
    t.integer  "condition_value", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "quests", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "description",    limit: 255
    t.integer  "reward_gift_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.integer  "required_item_id1",    limit: 4
    t.integer  "required_item_count1", limit: 4
    t.integer  "required_item_id2",    limit: 4
    t.integer  "required_item_count2", limit: 4
    t.integer  "required_item_id3",    limit: 4
    t.integer  "required_item_count3", limit: 4
    t.integer  "required_item_id4",    limit: 4
    t.integer  "required_item_count4", limit: 4
    t.integer  "required_item_id5",    limit: 4
    t.integer  "required_item_count5", limit: 4
    t.integer  "product_item_id",      limit: 4
    t.integer  "product_item_count",   limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "skill_id",             limit: 4
    t.integer  "difficulty",           limit: 4
  end

  create_table "resource_actions", force: :cascade do |t|
    t.integer  "action_type", limit: 4
    t.integer  "action_id",   limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "resource_keepers", force: :cascade do |t|
    t.integer  "target_id",         limit: 4
    t.integer  "current_count",     limit: 4
    t.datetime "last_recovered_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "lock_version",      limit: 4, default: 0, null: false
    t.integer  "resource_id",       limit: 4, default: 1
  end

  add_index "resource_keepers", ["target_id", "resource_id"], name: "index_resource_keepers_on_target_id_and_resource_id", unique: true, using: :btree

  create_table "resources", force: :cascade do |t|
    t.integer  "recover_count",    limit: 4
    t.integer  "recover_interval", limit: 4
    t.integer  "max_count",        limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name",             limit: 255
    t.integer  "item_id",          limit: 4
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

  create_table "shop_products", force: :cascade do |t|
    t.integer  "shop_id",    limit: 4
    t.integer  "item_id",    limit: 4
    t.integer  "count",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "shop_products", ["shop_id"], name: "index_shop_products_on_shop_id", using: :btree

  create_table "shops", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "showcases", force: :cascade do |t|
    t.integer  "shop_id",     limit: 4
    t.integer  "resource_id", limit: 4
    t.integer  "cost",        limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "soldiers", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.string   "description",             limit: 255
    t.integer  "attack_min",              limit: 4
    t.integer  "defense_min",             limit: 4
    t.integer  "hp_min",                  limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "attack_max",              limit: 4
    t.integer  "defense_max",             limit: 4
    t.integer  "hp_max",                  limit: 4
    t.integer  "level_max",               limit: 4
    t.integer  "critical_hit_chance_min", limit: 4,   default: 0, null: false
    t.integer  "critical_hit_chance_max", limit: 4,   default: 0, null: false
    t.integer  "critical_hit_damage_min", limit: 4,   default: 0, null: false
    t.integer  "critical_hit_damage_max", limit: 4,   default: 0, null: false
    t.integer  "dodge_chance_min",        limit: 4,   default: 0, null: false
    t.integer  "dodge_chance_max",        limit: 4,   default: 0, null: false
    t.integer  "damage_reduction_min",    limit: 4,   default: 0, null: false
    t.integer  "damage_reduction_max",    limit: 4,   default: 0, null: false
  end

  create_table "thrown_items", force: :cascade do |t|
    t.integer  "area_node_id", limit: 4
    t.integer  "item_id",      limit: 4
    t.integer  "count",        limit: 4
    t.datetime "thrown_at",                          null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "lock_version", limit: 4, default: 0, null: false
  end

  add_index "thrown_items", ["area_node_id", "item_id"], name: "index_thrown_items_on_area_node_id_and_item_id", unique: true, using: :btree

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

  create_table "user_banks", force: :cascade do |t|
    t.integer  "player_id",  limit: 4
    t.integer  "rails",      limit: 4, default: 0, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "user_banks", ["player_id"], name: "index_user_banks_on_player_id", unique: true, using: :btree

  create_table "user_encounter_enemies", force: :cascade do |t|
    t.integer  "player_id",  limit: 4
    t.integer  "enemy_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_encounter_enemies", ["player_id"], name: "index_user_encounter_enemies_on_player_id", using: :btree

  create_table "user_equipment_affixes", force: :cascade do |t|
    t.integer  "user_item_id",       limit: 4,             null: false
    t.integer  "equipment_affix_id", limit: 4,             null: false
    t.integer  "damage_perc",        limit: 4, default: 0
    t.integer  "attack_rating_perc", limit: 4, default: 0
    t.integer  "defense_perc",       limit: 4, default: 0
    t.integer  "hp",                 limit: 4, default: 0
    t.integer  "hp_steal_perc",      limit: 4, default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "user_equipment_affixes", ["user_item_id"], name: "index_user_equipment_affixes_on_user_item_id", using: :btree

  create_table "user_equipments", force: :cascade do |t|
    t.integer  "player_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "right_hand", limit: 4
    t.integer  "left_hand",  limit: 4
    t.integer  "both_hand",  limit: 4
    t.integer  "body",       limit: 4
    t.integer  "head",       limit: 4
    t.integer  "leg",        limit: 4
    t.integer  "neck",       limit: 4
    t.integer  "belt",       limit: 4
    t.integer  "amulet",     limit: 4
    t.integer  "ring_a",     limit: 4
    t.integer  "ring_b",     limit: 4
  end

  add_index "user_equipments", ["player_id"], name: "index_user_equipments_on_player_id_and_body_region", using: :btree

  create_table "user_items", force: :cascade do |t|
    t.integer  "player_id",  limit: 4
    t.integer  "item_id",    limit: 4
    t.integer  "count",      limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "equipped",   limit: 4, default: 0
  end

  add_index "user_items", ["player_id", "item_id"], name: "index_user_items_on_player_id_and_item_id", using: :btree

  create_table "user_progresses", force: :cascade do |t|
    t.integer  "progress_type", limit: 4
    t.integer  "progress_id",   limit: 4
    t.integer  "count",         limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "player_id",     limit: 4
  end

  add_index "user_progresses", ["player_id", "progress_type", "progress_id"], name: "index1", unique: true, using: :btree

  create_table "user_quests", force: :cascade do |t|
    t.integer  "player_id",  limit: 4
    t.integer  "quest_id",   limit: 4
    t.integer  "status",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_quests", ["player_id", "quest_id"], name: "index_user_quests_on_player_id_and_quest_id", unique: true, using: :btree

  create_table "user_skills", force: :cascade do |t|
    t.integer  "player_id",   limit: 4
    t.integer  "skill_id",    limit: 4
    t.integer  "skill_point", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "user_soldiers", force: :cascade do |t|
    t.integer  "player_id",   limit: 4
    t.integer  "soldier_id",  limit: 4
    t.integer  "current_hp",  limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "right_hand",  limit: 4, default: 0
    t.integer  "left_hand",   limit: 4, default: 0
    t.integer  "both_hand",   limit: 4, default: 0
    t.integer  "body",        limit: 4, default: 0
    t.integer  "head",        limit: 4, default: 0
    t.integer  "leg",         limit: 4, default: 0
    t.integer  "neck",        limit: 4, default: 0
    t.integer  "belt",        limit: 4, default: 0
    t.integer  "amulet",      limit: 4, default: 0
    t.integer  "ring_a",      limit: 4, default: 0
    t.integer  "ring_b",      limit: 4, default: 0
    t.integer  "exp",         limit: 4, default: 0
    t.integer  "is_in_party", limit: 4, default: 0
  end

  add_index "user_soldiers", ["player_id", "is_in_party"], name: "index_user_soldiers_on_player_id_and_is_in_party", using: :btree
  add_index "user_soldiers", ["player_id"], name: "index_user_soldiers_on_player_id", using: :btree

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
