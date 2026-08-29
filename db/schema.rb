# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_29_042122) do
  create_table "content_lists", force: :cascade do |t|
    t.integer "content_id", null: false
    t.string "content_type", null: false
    t.datetime "created_at", null: false
    t.integer "list_id", null: false
    t.integer "position"
    t.datetime "updated_at", null: false
    t.index ["content_type", "content_id"], name: "index_content_lists_on_content"
    t.index ["content_type", "content_id"], name: "index_content_lists_on_content_type_and_content_id"
    t.index ["list_id", "content_type", "position"], name: "index_content_lists_on_list_id_and_content_type_and_position"
    t.index ["list_id", "position"], name: "index_content_lists_on_list_id_and_position"
    t.index ["list_id"], name: "index_content_lists_on_list_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "original_title"
    t.integer "position"
    t.integer "season_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["season_id"], name: "index_episodes_on_season_id"
  end

  create_table "lists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "original_title"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "year"
  end

  create_table "seasons", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "original_title"
    t.integer "position"
    t.string "title"
    t.integer "tv_show_id", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.index ["tv_show_id"], name: "index_seasons_on_tv_show_id"
  end

  create_table "tv_shows", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "original_title"
    t.string "title"
    t.datetime "updated_at", null: false
    t.integer "year"
  end

  add_foreign_key "content_lists", "lists"
  add_foreign_key "episodes", "seasons"
  add_foreign_key "seasons", "tv_shows"
end
