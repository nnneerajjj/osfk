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

ActiveRecord::Schema.define(version: 20150427052651) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "commentable_id",   default: 0
    t.string   "commentable_type", default: ""
    t.string   "title",            default: ""
    t.text     "body",             default: ""
    t.string   "subject",          default: ""
    t.integer  "user_id",          default: 0,  null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "content"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "events", force: true do |t|
    t.integer  "created_by_id",                   null: false
    t.datetime "start_date",                      null: false
    t.datetime "end_date"
    t.string   "location"
    t.string   "address"
    t.string   "subject",                         null: false
    t.text     "content"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "can_participate", default: false
  end

  add_index "events", ["slug"], name: "index_events_on_slug", unique: true, using: :btree

  create_table "letters", force: true do |t|
    t.integer  "user_id",         null: false
    t.string   "subject",         null: false
    t.text     "content",         null: false
    t.boolean  "send_after_save"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link"
    t.datetime "sent_to_all_at"
  end

  create_table "news", force: true do |t|
    t.string   "subject"
    t.text     "content"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "active",     default: true
    t.boolean  "public",     default: false, null: false
    t.integer  "role_id"
  end

  add_index "news", ["slug"], name: "index_news_on_slug", unique: true, using: :btree

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",     default: false, null: false
    t.string   "slug"
    t.string   "header"
    t.string   "key"
    t.integer  "page_id"
    t.integer  "role_id"
    t.string   "url"
  end

  add_index "pages", ["page_id"], name: "index_pages_on_page_id", using: :btree
  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "participants", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["user_id", "event_id"], name: "index_participants_on_user_id_and_event_id", unique: true, using: :btree

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

  create_table "rich_rich_files", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        default: "file"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "slides", force: true do |t|
    t.string "header"
    t.string "header2"
    t.text   "content"
    t.string "link"
  end

  create_table "texts", force: true do |t|
    t.integer "page_id",              null: false
    t.string  "key",                  null: false
    t.text    "value",   default: ""
  end

  create_table "topics", force: true do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "public",     default: false, null: false
    t.integer  "role_id"
  end

  add_index "topics", ["slug"], name: "index_topics_on_slug", unique: true, using: :btree

  create_table "translations", force: true do |t|
    t.string   "locale"
    t.string   "key"
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: true do |t|
    t.integer  "uploader_id"
    t.string   "uploader_type"
    t.string   "type"
    t.string   "uuid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.string   "title",             default: ""
    t.string   "file_fingerprint"
    t.boolean  "file_processing"
  end

  add_index "uploads", ["uploader_id", "uploader_type"], name: "index_uploads_on_uploader_id_and_uploader_type", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "website"
    t.integer  "street_number"
    t.datetime "notification_date"
    t.integer  "house_number"
    t.string   "telephone"
    t.boolean  "active",                 default: true
    t.string   "water"
    t.string   "stock"
    t.boolean  "approved",               default: false, null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "regular",                default: true
    t.integer  "number"
    t.string   "identity_number"
    t.string   "address"
    t.string   "postal_address"
    t.boolean  "package1"
    t.boolean  "package2"
    t.integer  "card_number"
    t.string   "home_phone"
  end

  add_index "users", ["approved"], name: "index_users_on_approved", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
