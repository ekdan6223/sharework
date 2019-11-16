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

ActiveRecord::Schema.define(version: 2019_10_28_083547) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "alba_favs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "albafavs", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bussiness_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "applications", force: :cascade do |t|
    t.string "user_id"
    t.string "job_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "businessfavs", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bussiness_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bussinesses", force: :cascade do |t|
    t.string "bs_name"
    t.string "address"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_id"
    t.string "y"
    t.string "x"
    t.string "state"
  end

  create_table "favorites", force: :cascade do |t|
    t.string "user_id"
    t.string "y"
    t.string "x"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "count"
    t.string "fav_name"
  end

  create_table "identities", force: :cascade do |t|
    t.integer "user_id"
    t.string "provider"
    t.string "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "bussiness_id"
    t.string "date"
    t.string "time_start"
    t.string "time_end"
    t.string "pay"
    t.string "bs_name"
    t.string "address"
    t.string "phone"
    t.string "y"
    t.string "x"
    t.string "status"
    t.text "etc"
    t.string "personnel"
    t.integer "personnel_cnt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "day_payment"
  end

  create_table "lib_tags", force: :cascade do |t|
    t.string "sort"
    t.string "sectors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "lib_tag_id"
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "job_id"
    t.string "bussiness_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "provider", default: "", null: false
    t.string "profileImg", default: ""
    t.string "bankName", default: ""
    t.string "accountNum", default: ""
    t.string "status", default: ""
    t.string "address1", default: ""
    t.string "address2", default: ""
    t.string "phone", default: ""
    t.string "usertype", default: ""
    t.string "encrypted_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
