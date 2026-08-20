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

ActiveRecord::Schema[8.1].define(version: 2026_08_20_132556) do
  create_table "books", force: :cascade do |t|
    t.string "author"
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.text "notes"
    t.string "status"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_books_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "librarians", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.boolean "first_access"
    t.string "name"
    t.string "password_digest"
    t.datetime "updated_at", null: false
  end

  create_table "library_users", force: :cascade do |t|
    t.string "cpf"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "full_name"
    t.string "loan_password"
    t.string "phone"
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.integer "book_id", null: false
    t.datetime "created_at", null: false
    t.date "due_date"
    t.integer "library_user_id", null: false
    t.date "loan_date"
    t.boolean "returned"
    t.date "returned_at"
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_loans_on_book_id"
    t.index ["library_user_id"], name: "index_loans_on_library_user_id"
  end

  add_foreign_key "books", "categories"
  add_foreign_key "loans", "books"
  add_foreign_key "loans", "library_users"
end
