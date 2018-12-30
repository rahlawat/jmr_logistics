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

ActiveRecord::Schema.define(version: 20181230160706) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_entries", force: :cascade do |t|
    t.string   "bill_no"
    t.date     "payment_received_at"
    t.integer  "tds_percentage"
    t.integer  "entry_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["entry_id"], name: "index_bill_entries_on_entry_id", using: :btree
  end

  create_table "bill_payments", force: :cascade do |t|
    t.date     "date"
    t.string   "payment_mode"
    t.decimal  "amount"
    t.decimal  "others"
    t.string   "remarks"
    t.integer  "bill_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["bill_id"], name: "index_bill_payments_on_bill_id", using: :btree
  end

  create_table "bills", force: :cascade do |t|
    t.integer  "bill_number"
    t.decimal  "weight2"
    t.decimal  "kanta2"
    t.decimal  "rate2"
    t.integer  "tds_percentage"
    t.string   "party_code"
    t.integer  "entry_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["entry_id"], name: "index_bills_on_entry_id", using: :btree
  end

  create_table "entries", force: :cascade do |t|
    t.string   "truck_number"
    t.date     "entry_date"
    t.string   "station"
    t.string   "truck_owner"
    t.string   "firm"
    t.integer  "rate1"
    t.integer  "rate2"
    t.integer  "commission"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "self_advance_1"
    t.integer  "party_advance_2"
    t.integer  "invoice_number"
    t.date     "invoice_date"
    t.string   "company"
  end

  create_table "parties", force: :cascade do |t|
    t.string "party_name"
    t.string "party_code"
    t.string "gst_in"
    t.string "address"
    t.index ["party_name", "party_code"], name: "index_parties_on_party_name_and_party_code", unique: true, using: :btree
  end

  create_table "payment_summaries", force: :cascade do |t|
    t.string   "g_r_number"
    t.decimal  "weight"
    t.integer  "kanta"
    t.string   "shortage1"
    t.integer  "shortage2"
    t.integer  "payment_charges"
    t.string   "sheet_number"
    t.integer  "entry_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["entry_id"], name: "index_payment_summaries_on_entry_id", using: :btree
  end

  create_table "truck_details", force: :cascade do |t|
    t.string "truck_owner"
    t.string "truck_number"
    t.index ["truck_number"], name: "index_truck_details_on_truck_number", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bill_entries", "entries"
  add_foreign_key "bill_payments", "bills"
  add_foreign_key "bills", "entries"
  add_foreign_key "payment_summaries", "entries"
end
