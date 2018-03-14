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

ActiveRecord::Schema.define(version: 20180313041305) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_lessons", force: :cascade do |t|
    t.integer "course_id"
    t.integer "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.bigint "teacher_id"
    t.string "name"
    t.string "picture"
    t.boolean "blocked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "definitions", force: :cascade do |t|
    t.string "text"
    t.bigint "word_id"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_id"], name: "index_definitions_on_word_id"
  end

  create_table "lesson_words", force: :cascade do |t|
    t.integer "lesson_id"
    t.integer "word_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.boolean "blocked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_lessons_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "event"
    t.bigint "lesson_id"
    t.bigint "user_id"
    t.bigint "bookmarker_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bookmarker_id"], name: "index_notifications_on_bookmarker_id"
    t.index ["lesson_id"], name: "index_notifications_on_lesson_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "student_courses", force: :cascade do |t|
    t.integer "course_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.string "type"
    t.boolean "blocked_activity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "words", force: :cascade do |t|
    t.string "text"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "courses", "users", column: "teacher_id"
  add_foreign_key "definitions", "words"
  add_foreign_key "lessons", "users"
  add_foreign_key "notifications", "lessons"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "bookmarker_id"
end
