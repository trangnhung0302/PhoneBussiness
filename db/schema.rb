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

ActiveRecord::Schema[7.1].define(version: 2024_05_14_035737) do
  create_table "admins", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "carts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "item_id", null: false
    t.bigint "item_color_id"
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_carts_on_customer_id"
    t.index ["item_color_id"], name: "index_carts_on_item_color_id"
    t.index ["item_id"], name: "index_carts_on_item_id"
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customer_destinations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "recipient_name"
    t.string "recipient_phone"
    t.integer "province_id"
    t.string "province_name"
    t.integer "district_id"
    t.string "district_name"
    t.string "ward_code"
    t.string "ward_name"
    t.string "address"
    t.boolean "default"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customer_destinations_on_customer_id"
  end

  create_table "customers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "phone", null: false
    t.string "password_digest"
    t.integer "status", default: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
  end

  create_table "item_colors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.string "color"
    t.integer "quantity", null: false
    t.bigint "purchase_price", null: false
    t.bigint "original_price", null: false
    t.bigint "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_colors_on_item_id"
  end

  create_table "item_images", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_images_on_item_id"
  end

  create_table "items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "supplier_id", null: false
    t.string "name", null: false
    t.string "product_no", null: false
    t.integer "quantity", null: false
    t.bigint "purchase_price", null: false
    t.bigint "original_price", null: false
    t.bigint "price", null: false
    t.text "note"
    t.integer "order"
    t.integer "status"
    t.integer "view", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["supplier_id"], name: "index_items_on_supplier_id"
  end

  create_table "order_cancel_reasons", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "item_id", null: false
    t.bigint "item_color_id"
    t.integer "quantity", null: false
    t.bigint "purchase_price", null: false
    t.bigint "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_color_id"], name: "index_order_items_on_item_color_id"
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "payment_type_id", null: false
    t.bigint "staff_id"
    t.bigint "order_cancel_reason_id"
    t.bigint "customer_destination_id", null: false
    t.string "order_number", null: false
    t.bigint "total_price", null: false
    t.bigint "ship_amount", null: false
    t.string "message"
    t.integer "status", default: 10, null: false
    t.integer "payment_status", default: 10, null: false
    t.integer "transport_service_id", null: false
    t.string "transport_service_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_destination_id"], name: "index_orders_on_customer_destination_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["order_cancel_reason_id"], name: "index_orders_on_order_cancel_reason_id"
    t.index ["order_number"], name: "index_orders_on_order_number", unique: true
    t.index ["payment_type_id"], name: "index_orders_on_payment_type_id"
    t.index ["staff_id"], name: "index_orders_on_staff_id"
  end

  create_table "password_resets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "token", null: false
    t.datetime "expired_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_password_resets_on_customer_id"
  end

  create_table "password_settings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.string "token", null: false
    t.datetime "expired_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_password_settings_on_customer_id"
  end

  create_table "payment_types", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "bank_name"
    t.string "account_holders"
    t.string "account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.integer "ratings", null: false
    t.text "review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_reviews_on_order_id"
  end

  create_table "staffs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "name", null: false
    t.string "phone", null: false
    t.string "password_digest", null: false
    t.integer "status", default: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_staffs_on_email", unique: true
  end

  create_table "suppliers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "logo"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "carts", "customers"
  add_foreign_key "carts", "item_colors"
  add_foreign_key "carts", "items"
  add_foreign_key "customer_destinations", "customers"
  add_foreign_key "item_colors", "items"
  add_foreign_key "item_images", "items"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "suppliers"
  add_foreign_key "order_items", "item_colors"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "customer_destinations"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "order_cancel_reasons"
  add_foreign_key "orders", "payment_types"
  add_foreign_key "orders", "staffs"
  add_foreign_key "password_resets", "customers"
  add_foreign_key "password_settings", "customers"
  add_foreign_key "reviews", "orders"
end
