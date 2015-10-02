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

  create_table "award_types", force: :cascade do |t|
    t.string   "name"
    t.string   "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "awards", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "award_type_id"
    t.string   "reason"
    t.integer  "payment"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "behaviors", force: :cascade do |t|
    t.integer  "student_id"
    t.date     "date"
    t.boolean  "well_behaved"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "bonuses", force: :cascade do |t|
    t.integer  "period_id"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "reason"
  end

  create_table "daily_balances", force: :cascade do |t|
    t.integer  "student_id"
    t.date     "date"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extras", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "student_id"
    t.integer  "amount"
    t.string   "reason"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "instructors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "description"
    t.integer  "payscale"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.date     "last_date_done"
  end

  create_table "loans", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "recipient_id"
    t.float    "amount"
    t.float    "balance"
    t.integer  "interest"
    t.date     "end_date"
    t.integer  "weeks"
    t.boolean  "accepted"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "periods", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "payscale"
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "average_adjust"
<<<<<<< HEAD
  end

  create_table "purchase_trackers", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "item"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "store_item_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
=======
>>>>>>> master
  end

  create_table "rights", force: :cascade do |t|
    t.string   "description"
    t.integer  "instructor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "store_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "stock"
    t.integer  "instructor_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "student_right_assignments", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "right_id"
    t.integer  "cash_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "recipient_id"
    t.integer  "amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "reason"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.integer  "cash"
    t.integer  "period_id"
    t.boolean  "richest"
    t.boolean  "can_loan"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "disabled"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
