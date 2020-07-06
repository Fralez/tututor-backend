# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_05_023924) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "user_question_votes", force: :cascade do |t|
    t.boolean "negative", null: false
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.index ["question_id"], name: "index_user_question_votes_on_question_id"
    t.index ["user_id"], name: "index_user_question_votes_on_user_id"
  end

  create_table "user_saved_questions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.index ["question_id"], name: "index_user_saved_questions_on_question_id"
    t.index ["user_id"], name: "index_user_saved_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "password_digest", null: false
    t.string "identity_number", null: false
    t.string "name", default: "", null: false
    t.string "description", default: ""
    t.integer "gender", default: 0, null: false
    t.datetime "birth_date", null: false
    t.integer "reputation", default: 1
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["identity_number"], name: "index_users_on_identity_number", unique: true
  end

  add_foreign_key "questions", "users"
  add_foreign_key "user_question_votes", "questions"
  add_foreign_key "user_question_votes", "users"
  add_foreign_key "user_saved_questions", "questions"
  add_foreign_key "user_saved_questions", "users"
end
