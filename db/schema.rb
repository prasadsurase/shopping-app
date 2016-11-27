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

ActiveRecord::Schema.define(version: 20161127214746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "credit_cards", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "encrypted_number"
    t.string   "encrypted_number_iv"
    t.string   "encrypted_cvv"
    t.string   "encrypted_cvv_iv"
    t.date     "expiry_date"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["user_id"], name: "index_credit_cards_on_user_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",      precision: 8, scale: 2, default: "0.0"
    t.boolean  "active",                             default: true
    t.decimal  "discount",   precision: 8, scale: 2, default: "0.0"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "order_id"
    t.integer  "quantity",    default: 1
    t.float    "unit_price"
    t.float    "total_price"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["item_id"], name: "index_order_items_on_item_id", using: :btree
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "order_promo_codes", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "promo_code_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["order_id"], name: "index_order_promo_codes_on_order_id", using: :btree
    t.index ["promo_code_id"], name: "index_order_promo_codes_on_promo_code_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "state"
    t.decimal  "total",       precision: 8, scale: 2, default: "0.0"
    t.decimal  "discount",    precision: 8, scale: 2, default: "0.0"
    t.decimal  "final_total", precision: 8, scale: 2, default: "0.0"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "user_id"
  end

  create_table "promo_codes", force: :cascade do |t|
    t.string   "code"
    t.string   "description"
    t.string   "discount_type", default: "value"
    t.boolean  "combined",      default: true
    t.boolean  "active",        default: true
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "value",         default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.text     "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "credit_cards", "users"
  add_foreign_key "order_promo_codes", "orders"
  add_foreign_key "order_promo_codes", "promo_codes"
end
