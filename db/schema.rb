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

ActiveRecord::Schema.define(version: 20150628125743) do

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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
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
    t.integer  "lender_id"
    t.integer  "recipient_id"
    t.integer  "amount"
    t.integer  "interest"
    t.date     "end_date"
    t.boolean  "accepted"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "periods", force: :cascade do |t|
    t.integer  "instructor_id"
    t.integer  "payscale"
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "cash"
    t.integer  "period_id"
    t.string   "password_digest"
    t.boolean  "richest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "can_loan"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "reason"
  end

end
