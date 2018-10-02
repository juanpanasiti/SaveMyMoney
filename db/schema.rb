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

ActiveRecord::Schema.define(version: 2018_10_02_155017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "credit_cards", force: :cascade do |t|
    t.bigint "user_id"
    t.string "issuer"
    t.string "kind"
    t.date "expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "monthlies", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.decimal "amount"
    t.bigint "credit_card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["credit_card_id"], name: "index_monthlies_on_credit_card_id"
    t.index ["user_id"], name: "index_monthlies_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "payable_type"
    t.bigint "payable_id"
    t.string "fee"
    t.decimal "amount"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["payable_type", "payable_id"], name: "index_payments_on_payable_type_and_payable_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.bigint "credit_card_id"
    t.decimal "amount"
    t.integer "fees"
    t.date "first_payment"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["credit_card_id"], name: "index_purchases_on_credit_card_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "name"
    t.string "service"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_taxes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "access_lvl", default: 0, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "credit_cards", "users"
  add_foreign_key "monthlies", "credit_cards"
  add_foreign_key "monthlies", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "purchases", "credit_cards"
  add_foreign_key "purchases", "users"
  add_foreign_key "taxes", "users"
end
