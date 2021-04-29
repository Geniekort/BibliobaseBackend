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

ActiveRecord::Schema.define(version: 2021_04_19_091528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audit_actions", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "created_by_id", null: false
    t.string "action_detailer_type"
    t.bigint "action_detailer_id"
    t.string "type"
    t.jsonb "meta", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["action_detailer_type", "action_detailer_id"], name: "index_audit_actions_on_action_detailer"
    t.index ["created_by_id"], name: "index_audit_actions_on_created_by_id"
    t.index ["project_id"], name: "index_audit_actions_on_project_id"
    t.index ["type"], name: "index_audit_actions_on_type"
  end

  create_table "audit_curation_actions", force: :cascade do |t|
    t.string "curation_type"
    t.bigint "curation_session_id"
    t.bigint "created_data_object_id"
    t.bigint "import_record_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["created_data_object_id"], name: "index_audit_curation_actions_on_created_data_object_id"
    t.index ["curation_session_id"], name: "index_audit_curation_actions_on_curation_session_id"
    t.index ["curation_type"], name: "index_audit_curation_actions_on_curation_type"
    t.index ["import_record_id"], name: "index_audit_curation_actions_on_import_record_id"
  end

  create_table "audit_resource_actions", force: :cascade do |t|
    t.string "type"
    t.string "resource_type"
    t.bigint "resource_id"
    t.jsonb "old_attributes", default: {}
    t.jsonb "new_attributes", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["resource_type", "resource_id"], name: "index_audit_resource_actions_on_resource"
    t.index ["type"], name: "index_audit_resource_actions_on_type"
  end

  create_table "curation_sessions", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "data_type_id", null: false
    t.bigint "import_id", null: false
    t.bigint "started_by_id", null: false
    t.jsonb "mapping", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["data_type_id"], name: "index_curation_sessions_on_data_type_id"
    t.index ["import_id"], name: "index_curation_sessions_on_import_id"
    t.index ["project_id"], name: "index_curation_sessions_on_project_id"
    t.index ["started_by_id"], name: "index_curation_sessions_on_started_by_id"
  end

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

  create_table "import_records", force: :cascade do |t|
    t.bigint "import_id", null: false
    t.jsonb "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["import_id"], name: "index_import_records_on_import_id"
  end

  create_table "imports", force: :cascade do |t|
    t.string "name"
    t.string "raw_data"
    t.jsonb "meta"
    t.jsonb "parsed_data"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "parsed", default: false
    t.index ["project_id"], name: "index_imports_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "audit_actions", "users", column: "created_by_id"
  add_foreign_key "curation_sessions", "data_data_types", column: "data_type_id"
  add_foreign_key "curation_sessions", "imports"
  add_foreign_key "curation_sessions", "users", column: "started_by_id"
  add_foreign_key "data_attributes", "data_data_types", column: "data_type_id"
  add_foreign_key "data_data_objects", "data_data_types", column: "data_type_id"
  add_foreign_key "data_data_objects", "projects"
  add_foreign_key "data_data_types", "projects"
  add_foreign_key "import_records", "imports"
  add_foreign_key "imports", "projects"
end
