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

ActiveRecord::Schema.define(version: 20161126110159) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.float    "price",      default: 0.0
    t.boolean  "active",     default: true
    t.integer  "discount",   default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
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
    t.float    "total",      default: 0.0
    t.float    "discount",   default: 0.0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
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

  add_foreign_key "order_promo_codes", "orders"
  add_foreign_key "order_promo_codes", "promo_codes"
end
