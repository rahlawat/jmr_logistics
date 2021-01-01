# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_01_102127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bill_payments", id: :serial, force: :cascade do |t|
    t.date "date"
    t.string "payment_mode"
    t.decimal "amount"
    t.decimal "others"
    t.string "remarks"
    t.integer "bill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_bill_payments_on_bill_id"
  end

  create_table "bills", id: :serial, force: :cascade do |t|
    t.string "bill_number"
    t.decimal "weight2"
    t.decimal "kanta2"
    t.decimal "tds_percentage", precision: 5, scale: 2
    t.integer "entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "party_invoice_id"
    t.index ["entry_id"], name: "index_bills_on_entry_id"
    t.index ["party_invoice_id"], name: "index_bills_on_party_invoice_id"
  end

  create_table "entries", id: :serial, force: :cascade do |t|
    t.string "truck_number"
    t.date "entry_date"
    t.string "station"
    t.string "truck_owner"
    t.string "firm"
    t.integer "rate1"
    t.integer "rate2"
    t.integer "commission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "self_advance_1"
    t.integer "party_advance_2"
    t.integer "invoice_number"
    t.date "invoice_date"
    t.string "company"
    t.integer "party_invoice_id"
    t.string "party_code"
    t.index ["party_invoice_id"], name: "index_entries_on_party_invoice_id"
  end

  create_table "opening_balances", id: :serial, force: :cascade do |t|
    t.integer "year"
    t.integer "party_id"
    t.integer "balance"
    t.index ["party_id"], name: "index_opening_balances_on_party_id"
  end

  create_table "parties", id: :serial, force: :cascade do |t|
    t.string "party_name"
    t.string "party_code"
    t.string "gst_in"
    t.string "address"
    t.index ["party_name", "party_code"], name: "index_parties_on_party_name_and_party_code", unique: true
  end

  create_table "party_invoices", id: :serial, force: :cascade do |t|
    t.string "party_code"
    t.string "invoice_number"
    t.date "date"
    t.boolean "invoice_generated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "invoice_cancelled", default: false
    t.string "reason_for_cancellation"
    t.integer "revised_invoice_id"
    t.index ["invoice_number"], name: "index_party_invoices_on_invoice_number", unique: true
  end

  create_table "payment_receipts", id: :serial, force: :cascade do |t|
    t.string "mode_of_payment"
    t.date "date"
    t.integer "amount"
    t.integer "cheque_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "party_id"
    t.string "party_code"
    t.string "remark"
    t.string "depository_bank"
    t.index ["party_id"], name: "index_payment_receipts_on_party_id"
  end

  create_table "payment_summaries", id: :serial, force: :cascade do |t|
    t.string "g_r_number"
    t.decimal "weight"
    t.integer "kanta"
    t.string "shortage1"
    t.integer "shortage2"
    t.integer "payment_charges"
    t.integer "entry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_id"], name: "index_payment_summaries_on_entry_id"
  end

  create_table "truck_details", id: :serial, force: :cascade do |t|
    t.string "truck_owner"
    t.string "truck_number"
    t.index ["truck_number"], name: "index_truck_details_on_truck_number", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bill_payments", "bills"
  add_foreign_key "bills", "entries"
  add_foreign_key "bills", "party_invoices"
  add_foreign_key "entries", "party_invoices"
  add_foreign_key "opening_balances", "parties"
  add_foreign_key "payment_receipts", "parties"
  add_foreign_key "payment_summaries", "entries"
end
