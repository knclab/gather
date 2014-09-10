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

ActiveRecord::Schema.define(version: 20140909113050) do

  create_table "categories", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "media", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",    null: false
    t.integer  "tag_id",         null: false
    t.string   "media_id"
    t.text     "attribution"
    t.text     "tags"
    t.string   "media_type"
    t.text     "location"
    t.text     "comments"
    t.string   "filter"
    t.integer  "created_time"
    t.string   "link"
    t.text     "likes"
    t.text     "images"
    t.text     "videos"
    t.text     "users_in_photo"
    t.text     "caption"
    t.text     "user_has_liked"
    t.text     "user"
  end

  add_index "media", ["category_id"], name: "index_media_on_category_id", using: :btree
  add_index "media", ["created_at"], name: "index_media_on_created_at", using: :btree
  add_index "media", ["created_time"], name: "index_media_on_created_time", using: :btree
  add_index "media", ["media_id"], name: "index_media_on_media_id", using: :btree
  add_index "media", ["tag_id"], name: "index_media_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id",           null: false
    t.string   "name"
    t.integer  "media_count", limit: 8
  end

  add_index "tags", ["category_id"], name: "index_tags_on_category_id", using: :btree

end
