ActiveRecord::Schema.define(version: 20170205172503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_tags", force: :cascade do |t|
    t.integer "exercise_id"
    t.integer "tag_id"
    t.index ["exercise_id"], name: "index_exercise_tags_on_exercise_id", using: :btree
    t.index ["tag_id"], name: "index_exercise_tags_on_tag_id", using: :btree
  end

  create_table "exercises", force: :cascade do |t|
    t.text     "name"
    t.text     "content"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description"
  end

  create_table "solutions", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "exercise_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "status",      default: 0
    t.index ["exercise_id"], name: "index_solutions_on_exercise_id", using: :btree
    t.index ["user_id"], name: "index_solutions_on_user_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "census_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "exercise_tags", "exercises"
  add_foreign_key "exercise_tags", "tags"
  add_foreign_key "solutions", "exercises"
  add_foreign_key "solutions", "users"
end
