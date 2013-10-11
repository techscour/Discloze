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

ActiveRecord::Schema.define(version: 20130930153952) do

  create_table "app_of_publics", force: true do |t|
    t.integer  "public_id"
    t.integer  "partner_app_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "app_of_publics", ["partner_app_id"], name: "index_app_of_publics_on_partner_app_id"
  add_index "app_of_publics", ["public_id"], name: "index_app_of_publics_on_public_id"

  create_table "invitations", force: true do |t|
    t.integer  "public_id"
    t.integer  "partner_id"
    t.string   "headline"
    t.string   "list"
    t.text     "html"
    t.datetime "posted"
    t.datetime "effective"
    t.datetime "expires"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["partner_id"], name: "index_invitations_on_partner_id"
  add_index "invitations", ["public_id"], name: "index_invitations_on_public_id"

  create_table "listables", force: true do |t|
    t.string   "name"
    t.string   "topic"
    t.string   "description"
    t.text     "html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", force: true do |t|
    t.integer  "public_id"
    t.string   "name"
    t.string   "visibility"
    t.text     "values"
    t.datetime "last_activity"
    t.datetime "created"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lists", ["public_id"], name: "index_lists_on_public_id"

  create_table "logins", force: true do |t|
    t.integer  "public_id"
    t.datetime "last_activity"
    t.boolean  "remember"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logins", ["public_id"], name: "index_logins_on_public_id"

  create_table "notices", force: true do |t|
    t.integer  "public_id"
    t.string   "headline"
    t.text     "html"
    t.datetime "posted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notices", ["public_id"], name: "index_notices_on_public_id"

  create_table "offers", force: true do |t|
    t.integer  "public_id"
    t.integer  "partner_id"
    t.string   "list"
    t.string   "headline"
    t.text     "html"
    t.datetime "posted"
    t.datetime "effective"
    t.datetime "expires"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offers", ["partner_id"], name: "index_offers_on_partner_id"
  add_index "offers", ["public_id"], name: "index_offers_on_public_id"

  create_table "partner_apps", force: true do |t|
    t.integer  "partner_id"
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.text     "html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partner_apps", ["partner_id"], name: "index_partner_apps_on_partner_id"

  create_table "partner_sites", force: true do |t|
    t.integer  "partner_id"
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.text     "html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "partner_sites", ["partner_id"], name: "index_partner_sites_on_partner_id"

  create_table "partners", force: true do |t|
    t.string   "stormpath_id"
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.string   "html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publics", force: true do |t|
    t.string   "stormpath_id"
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "site_of_publics", force: true do |t|
    t.integer  "public_id"
    t.integer  "partner_site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_of_publics", ["partner_site_id"], name: "index_site_of_publics_on_partner_site_id"
  add_index "site_of_publics", ["public_id"], name: "index_site_of_publics_on_public_id"

  create_table "tokens", force: true do |t|
    t.integer  "partner_id"
    t.string   "token_value"
    t.datetime "last_login"
    t.datetime "last_activity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tokens", ["partner_id"], name: "index_tokens_on_partner_id"

  create_table "updates", force: true do |t|
    t.integer  "public_id"
    t.integer  "partner_id"
    t.string   "list"
    t.string   "headline"
    t.text     "html"
    t.datetime "posted"
    t.datetime "effective"
    t.datetime "expires"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "updates", ["partner_id"], name: "index_updates_on_partner_id"
  add_index "updates", ["public_id"], name: "index_updates_on_public_id"

end
