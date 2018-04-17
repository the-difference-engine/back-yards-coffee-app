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

ActiveRecord::Schema.define(version: 20180413004445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carted_products", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.bigint   "customer_id"
    t.string   "product_id"
    t.integer  "quantity"
    t.string   "status"
    t.integer  "grind_id"
    t.integer  "order_id"
    t.string   "sku"
    t.string   "name"
    t.integer  "price"
  end

  create_table "carted_subscriptions", force: :cascade do |t|
    t.integer  "quantity"
    t.string   "plan_id"
    t.string   "status"
    t.bigint   "customer_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "amount"
    t.string   "interval"
    t.integer  "interval_count"
    t.string   "plan_name"
    t.string   "product_id"
    t.string   "sku"
    t.jsonb    "products",         default: "{}", null: false
    t.string   "plan"
    t.datetime "expired_at"
    t.datetime "order_created_at"
    t.date     "next_order_date"
    t.index ["products"], name: "index_carted_subscriptions_on_products", using: :gin
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", id: :bigserial, force: :cascade do |t|
    t.string   "email",                  default: "", null: false
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
    t.string   "stripe_customer_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip_code"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "Address2"
    t.boolean  "wholesaler"
    t.index ["email"], name: "index_customers_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true, using: :btree
  end

  create_table "employees", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
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
    t.boolean  "admin"
    t.index ["email"], name: "index_employees_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "stripe_order_id"
    t.integer  "customer_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.decimal  "price",       precision: 5, scale: 2
    t.integer  "category_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "wholesalers", force: :cascade do |t|
    t.string   "business_name"
    t.string   "contact_name"
    t.string   "title"
    t.string   "work_phone"
    t.string   "alternate_phone"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "billing_address"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "billing_zip_code"
    t.string   "shipping_address"
    t.string   "shipping_city"
    t.string   "shipping_state"
    t.string   "shipping_zip_code"
    t.string   "website"
    t.string   "accounts_payable_contact_name"
    t.string   "accounts_payable_contact_email"
    t.string   "accounts_payable_contact_phone"
    t.boolean  "retailer"
    t.boolean  "tax_exempt"
    t.string   "delivery_instructions"
    t.string   "recieving_hours"
    t.string   "days_closed"
    t.integer  "customer_id"
    t.boolean  "is_approved",                    default: false
    t.boolean  "is_rejected",                    default: false
  end

end
