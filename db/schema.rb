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

ActiveRecord::Schema.define(version: 20170411152315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branches", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "subtotal_amt"
    t.float    "grand_total_amt"
    t.float    "shipping_amt"
    t.boolean  "is_offer"
    t.boolean  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "category_name"
    t.string   "category_code"
    t.boolean  "status"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "mobile"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "quantity"
    t.float    "item_price"
    t.float    "item_price_with_quantity"
    t.text     "item_description"
    t.integer  "item_id"
    t.string   "mobile_no"
    t.string   "user_email"
    t.string   "order_status"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cart_id"
    t.float    "total_price"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "mobile"
    t.string   "landline_no"
    t.text     "address"
    t.string   "city"
    t.string   "state"
    t.string   "pincode"
    t.string   "shipping_first_name"
    t.string   "shipping_last_name"
    t.string   "shipping_email"
    t.string   "shipping_mobile"
    t.string   "shipping_landline_no"
    t.text     "shipping_address"
    t.string   "shipping_city"
    t.string   "shipping_state"
    t.string   "shipping_pincode"
    t.string   "shipping_landmark"
    t.string   "landmark"
    t.string   "payment_type"
    t.string   "order_status"
    t.datetime "exp_delivery_date"
    t.boolean  "is_offer"
    t.string   "coupon_code"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "branch_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "product_name"
    t.string   "product_code"
    t.integer  "category_id"
    t.text     "product_description"
    t.float    "price"
    t.boolean  "status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "mobile_number"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role_id"
    t.integer  "branch_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
