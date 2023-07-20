ActiveRecord::Schema[7.0].define(version: 2023_07_20_074908) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_expenses", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "expense_id", null: false
    t.index ["category_id", "expense_id"], name: "index_categories_expenses_on_category_id_and_expense_id"
    t.index ["expense_id", "category_id"], name: "index_categories_expenses_on_expense_id_and_category_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "expenses", "users"
end
