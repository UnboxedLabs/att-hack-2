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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121215173315) do

  create_table "api_keys", :force => true do |t|
    t.string   "access_token"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "devices", :force => true do |t|
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "posts", :force => true do |t|
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "user_id"
    t.integer  "up_votes",    :default => 0, :null => false
    t.integer  "down_votes",  :default => 0, :null => false
    t.string   "avatar"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.boolean  "temporary"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "up_votes",   :default => 0, :null => false
    t.integer  "down_votes", :default => 0, :null => false
  end

  create_table "votings", :force => true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "up_vote",       :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

end
