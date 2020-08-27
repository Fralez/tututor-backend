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

ActiveRecord::Schema.define(version: 2020_08_27_161234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text "description", null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "category_to_questions", force: :cascade do |t|
    t.bigint "question_category_id", null: false
    t.bigint "question_id", null: false
    t.index ["question_category_id"], name: "index_category_to_questions_on_question_category_id"
    t.index ["question_id"], name: "index_category_to_questions_on_question_id"
  end

  create_table "channels", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "users_id", null: false
    t.bigint "messages_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["messages_id"], name: "index_channels_on_messages_id"
    t.index ["users_id"], name: "index_channels_on_users_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "channel_id", null: false
    t.index ["channel_id"], name: "index_messages_on_channel_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "question_categories", force: :cascade do |t|
    t.string "title", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string "title", null: false
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "correct_answer_id"
    t.index ["correct_answer_id"], name: "index_questions_on_correct_answer_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "user_answer_votes", force: :cascade do |t|
    t.boolean "negative", null: false
    t.bigint "user_id", null: false
    t.bigint "answer_id", null: false
    t.index ["answer_id"], name: "index_user_answer_votes_on_answer_id"
    t.index ["user_id"], name: "index_user_answer_votes_on_user_id"
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
    t.bigint "messages_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["identity_number"], name: "index_users_on_identity_number", unique: true
    t.index ["messages_id"], name: "index_users_on_messages_id"
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "category_to_questions", "question_categories"
  add_foreign_key "category_to_questions", "questions"
  add_foreign_key "channels", "messages", column: "messages_id"
  add_foreign_key "channels", "users", column: "users_id"
  add_foreign_key "messages", "channels"
  add_foreign_key "messages", "users"
  add_foreign_key "questions", "answers", column: "correct_answer_id"
  add_foreign_key "questions", "users"
  add_foreign_key "user_answer_votes", "answers"
  add_foreign_key "user_answer_votes", "users"
  add_foreign_key "user_question_votes", "questions"
  add_foreign_key "user_question_votes", "users"
  add_foreign_key "user_saved_questions", "questions"
  add_foreign_key "user_saved_questions", "users"
  add_foreign_key "users", "messages", column: "messages_id"
end
