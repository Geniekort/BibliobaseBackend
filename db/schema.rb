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

ActiveRecord::Schema.define(version: 2021_03_05_085613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "data_attributes", force: :cascade do |t|
    t.string "attribute_type"
    t.string "name"
    t.jsonb "validation_definition", default: {}
    t.bigint "data_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data_type_id"], name: "index_data_attributes_on_data_type_id"
  end

  create_table "data_data_objects", force: :cascade do |t|
    t.jsonb "data", default: {}
    t.bigint "data_type_id", null: false
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data_type_id"], name: "index_data_data_objects_on_data_type_id"
    t.index ["project_id"], name: "index_data_data_objects_on_project_id"
  end

  create_table "data_data_types", force: :cascade do |t|
    t.jsonb "definition"
    t.string "name"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_data_data_types_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "data_attributes", "data_data_types", column: "data_type_id"
  add_foreign_key "data_data_objects", "data_data_types", column: "data_type_id"
  add_foreign_key "data_data_objects", "projects"
  add_foreign_key "data_data_types", "projects"
end
