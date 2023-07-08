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

ActiveRecord::Schema[7.0].define(version: 2023_07_08_132818) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "budgets", force: :cascade do |t|
    t.bigint "wallet_id", null: false
    t.bigint "category_id", null: false
    t.integer "month", null: false
    t.integer "year", null: false
    t.float "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "spend", default: 0.0
    t.index ["category_id"], name: "index_budgets_on_category_id"
    t.index ["wallet_id"], name: "index_budgets_on_wallet_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "installments", force: :cascade do |t|
    t.date "due_date"
    t.float "amount"
    t.bigint "loan_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_installments_on_loan_id"
  end

  create_table "loans", force: :cascade do |t|
    t.integer "number_of_installment"
    t.string "title"
    t.float "amount"
    t.integer "number_of_paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wallet_id", null: false
    t.index ["wallet_id"], name: "index_loans_on_wallet_id"
  end

  create_table "wallet_transactions", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "wallet_id", null: false
    t.text "description"
    t.float "amount", null: false
    t.date "at_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_wallet_transactions_on_category_id"
    t.index ["wallet_id"], name: "index_wallet_transactions_on_wallet_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.string "name"
    t.float "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "budgets", "categories"
  add_foreign_key "budgets", "wallets"
  add_foreign_key "installments", "loans"
  add_foreign_key "wallet_transactions", "categories"
  add_foreign_key "wallet_transactions", "wallets"
end
