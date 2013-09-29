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

ActiveRecord::Schema.define(version: 20130929180737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "headlines", force: true do |t|
    t.datetime "date"
    t.string   "content"
    t.string   "archive_url"
    t.integer  "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "headlines", ["content"], name: "index_headlines_on_content", using: :btree
  add_index "headlines", ["date"], name: "index_headlines_on_date", using: :btree

  create_table "sandboxes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sentiment_data", force: true do |t|
    t.decimal  "sentiment_score"
    t.string   "sentiment_description"
    t.string   "sentiment_engine"
    t.integer  "headline_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sentiment_data", ["sentiment_description"], name: "index_sentiment_data_on_sentiment_description", using: :btree
  add_index "sentiment_data", ["sentiment_engine"], name: "index_sentiment_data_on_sentiment_engine", using: :btree
  add_index "sentiment_data", ["sentiment_score"], name: "index_sentiment_data_on_sentiment_score", using: :btree

  create_table "sources", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
