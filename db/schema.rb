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

ActiveRecord::Schema.define(version: 20170328143342) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string   "source"
    t.integer  "date"
    t.string   "web_url"
    t.string   "title"
    t.string   "image_url"
    t.string   "snippet"
    t.integer  "word_count"
    t.integer  "views"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "topic_id"
    t.integer  "subtopic_id"
  end

  add_index "articles", ["subtopic_id"], name: "index_articles_on_subtopic_id", using: :btree
  add_index "articles", ["topic_id"], name: "index_articles_on_topic_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "genre"
    t.string   "author"
    t.string   "title"
    t.string   "image_url"
    t.string   "snippet"
    t.string   "review_url"
    t.string   "amazon_url"
    t.integer  "review_views"
    t.integer  "amazon_views"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "topic_id"
    t.integer  "subtopic_id"
  end

  add_index "books", ["subtopic_id"], name: "index_books_on_subtopic_id", using: :btree
  add_index "books", ["topic_id"], name: "index_books_on_topic_id", using: :btree

  create_table "podcasts", force: :cascade do |t|
    t.string   "source"
    t.integer  "date"
    t.string   "web_url"
    t.string   "title"
    t.string   "image_url"
    t.string   "snippet"
    t.integer  "duration"
    t.integer  "views"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "topic_id"
    t.integer  "subtopic_id"
  end

  add_index "podcasts", ["subtopic_id"], name: "index_podcasts_on_subtopic_id", using: :btree
  add_index "podcasts", ["topic_id"], name: "index_podcasts_on_topic_id", using: :btree

  create_table "subtopics", force: :cascade do |t|
    t.string   "subtopic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "topic_id"
  end

  add_index "subtopics", ["topic_id"], name: "index_subtopics_on_topic_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "topics", ["topic"], name: "index_topics_on_topic", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_status",           default: "daily", null: false
    t.boolean  "books",                  default: true,    null: false
    t.integer  "topics",                 default: [],                   array: true
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  add_foreign_key "articles", "subtopics"
  add_foreign_key "articles", "topics"
  add_foreign_key "books", "subtopics"
  add_foreign_key "books", "topics"
  add_foreign_key "podcasts", "subtopics"
  add_foreign_key "podcasts", "topics"
  add_foreign_key "subtopics", "topics"
end
