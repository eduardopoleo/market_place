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

ActiveRecord::Schema.define(version: 20150418004231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: true do |t|
    t.integer  "subtotal"
    t.integer  "tax"
    t.integer  "shipping"
    t.integer  "total"
    t.boolean  "active"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", force: true do |t|
    t.integer "unit_price"
    t.integer "quantity"
    t.integer "total_price"
    t.integer "product_id"
    t.integer "cart_id"
  end

  create_table "payments", force: true do |t|
    t.integer  "user_id"
    t.integer  "amount"
    t.string   "reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cart_id"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "price"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "cover"
  end

  create_table "users", force: true do |t|
    t.string  "email"
    t.string  "full_name"
    t.string  "password_digest"
    t.boolean "admin"
    t.integer "group_id"
  end

end
