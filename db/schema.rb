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

ActiveRecord::Schema.define(version: 20150623093301) do

  create_table "builds", force: :cascade do |t|
    t.integer  "bundle_id"
    t.string   "version",    null: false
    t.string   "build",      null: false
    t.string   "file"
    t.string   "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "builds", ["build"], name: "index_builds_on_build"
  add_index "builds", ["bundle_id"], name: "index_builds_on_bundle_id"
  add_index "builds", ["version"], name: "index_builds_on_version"

  create_table "bundles", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "identifier", null: false
    t.string   "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bundles", ["identifier"], name: "index_bundles_on_identifier"

  create_table "devices", force: :cascade do |t|
    t.string   "owner"
    t.string   "product"
    t.string   "serial"
    t.string   "udid",       null: false
    t.string   "token",      null: false
    t.string   "version"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "devices", ["token"], name: "index_devices_on_token"
  add_index "devices", ["udid"], name: "index_devices_on_udid"

end
