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

ActiveRecord::Schema.define(version: 20161207023444) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "confirmed_passengers", force: :cascade do |t|
    t.integer  "route_pool_id"
    t.integer  "user_id"
    t.string   "passenger_name"
    t.string   "passenger_last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "route_poolings", force: :cascade do |t|
    t.datetime "arrival_date_time"
    t.string   "origin_place"
    t.string   "origin_city"
    t.integer  "origin_google_id"
    t.string   "destination_place"
    t.string   "destination_city"
    t.integer  "user_id"
    t.integer  "route_request_id"
    t.integer  "passengers_pooled"
    t.integer  "average_buffer_time"
    t.time     "google_suggested_departure_time"
    t.boolean  "confirmed_route"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "route_requests", force: :cascade do |t|
    t.text     "origin_query"
    t.string   "origin_city"
    t.string   "origin_place"
    t.string   "origin_google_id"
    t.text     "destination_query"
    t.string   "destination_city"
    t.string   "destination_place"
    t.string   "destination_google_id"
    t.datetime "destination_arrival_date_time"
    t.time     "max_time_in_advance"
    t.integer  "user_id"
    t.datetime "origin_google_suggested_departure_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password"
    t.string   "name"
    t.string   "father_last_name"
    t.string   "mother_last_name"
    t.string   "middle_name"
    t.integer  "phone_number"
    t.integer  "mobile_number"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
