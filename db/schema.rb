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

ActiveRecord::Schema.define(version: 20131125045829) do

  create_table "admin_users", force: true do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree

  create_table "project_file_media_queries", force: true do |t|
    t.integer  "project_file_id"
    t.text     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_file_media_queries", ["project_file_id"], name: "index_media_queries_on_project_file_id", using: :btree

  create_table "project_file_media_query_selector_properties", force: true do |t|
    t.integer  "project_file_media_query_selector_id"
    t.string   "name"
    t.string   "value"
    t.integer  "is_important",                         limit: 1
    t.integer  "line"
    t.integer  "start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_file_media_query_selector_properties", ["is_important"], name: "index_properties_on_is_important", using: :btree
  add_index "project_file_media_query_selector_properties", ["name"], name: "index_properties_on_name", using: :btree
  add_index "project_file_media_query_selector_properties", ["project_file_media_query_selector_id"], name: "index_properties_on_project_file_media_query_selector_id", using: :btree
  add_index "project_file_media_query_selector_properties", ["value"], name: "index_properties_on_value", using: :btree

  create_table "project_file_media_query_selector_similarities", force: true do |t|
    t.integer  "current_selector_id"
    t.integer  "compared_selector_id"
    t.float    "property"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_file_media_query_selector_similarities", ["compared_selector_id"], name: "index_similarities_on_compared_selector_id", using: :btree
  add_index "project_file_media_query_selector_similarities", ["current_selector_id", "compared_selector_id"], name: "index_similarities_on_selector_ids", unique: true, using: :btree
  add_index "project_file_media_query_selector_similarities", ["current_selector_id"], name: "index_similarities_on_current_selector_id", using: :btree

  create_table "project_file_media_query_selectors", force: true do |t|
    t.integer  "project_file_media_query_id"
    t.string   "name"
    t.integer  "line"
    t.integer  "start"
    t.text     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_file_media_query_selectors", ["name"], name: "index_selectors_on_name", type: :fulltext
  add_index "project_file_media_query_selectors", ["project_file_media_query_id"], name: "index_selectors_on_project_file_media_query_id", using: :btree

  create_table "project_files", force: true do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_files", ["status"], name: "index_project_files_on_status", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

end
