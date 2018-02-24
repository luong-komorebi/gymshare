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

ActiveRecord::Schema.define(version: 20180224100908) do

  create_table "exercises", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "weight"
    t.integer "reps"
    t.integer "round_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_exercises_on_round_id"
  end

  create_table "rests", force: :cascade do |t|
    t.time "rest_time"
    t.integer "round_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["round_id"], name: "index_rests_on_round_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "repitition"
    t.integer "workout_plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workout_plan_id"], name: "index_rounds_on_workout_plan_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.float "weight"
    t.float "height"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workout_plans", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "score"
    t.datetime "published_at"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workout_plans_on_user_id"
  end

end
