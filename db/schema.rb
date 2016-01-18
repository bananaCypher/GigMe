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

ActiveRecord::Schema.define(version: 20160118092317) do

  create_table "acts", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "acts_keywords", force: :cascade do |t|
    t.integer "act_id"
    t.integer "keyword_id"
  end

  create_table "bitcoin_payment_transactions", force: :cascade do |t|
    t.integer  "estimated_value"
    t.string   "transaction_hash"
    t.string   "block_hash"
    t.datetime "block_time"
    t.datetime "estimated_time"
    t.integer  "bitcoin_payment_id"
    t.integer  "btc_conversion"
  end

  add_index "bitcoin_payment_transactions", ["bitcoin_payment_id"], name: "index_bitcoin_payment_transactions_on_bitcoin_payment_id"

  create_table "bitcoin_payments", force: :cascade do |t|
    t.string   "payable_type"
    t.integer  "payable_id"
    t.string   "currency"
    t.string   "reason"
    t.integer  "price"
    t.float    "btc_amount_due", default: 0.0
    t.string   "address"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "btc_conversion"
  end

  add_index "bitcoin_payments", ["payable_type", "payable_id"], name: "index_bitcoin_payments_on_payable_type_and_payable_id"

  create_table "bookings", force: :cascade do |t|
    t.string   "user_id"
    t.string   "integer"
    t.string   "gig_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  create_table "currency_conversions", force: :cascade do |t|
    t.float    "currency"
    t.integer  "btc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gigs", force: :cascade do |t|
    t.decimal  "price"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "capacity"
    t.integer  "act_id"
    t.integer  "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keywords", force: :cascade do |t|
    t.string   "tag"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "gig_id"
    t.integer  "rating"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.integer  "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal  "latitude"
    t.decimal  "longitude"
  end

end
