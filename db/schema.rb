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

ActiveRecord::Schema.define(:version => 20110615050601) do

  create_table "accounts", :force => true do |t|
    t.string   "account_type"
    t.decimal  "balance",      :precision => 12, :scale => 2, :default => 0.0
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "pin_digest"
    t.decimal  "balance",         :precision => 12, :scale => 2, :default => 0.0
    t.integer  "failed_attempts",                                :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "source_account_id"
    t.integer  "target_account_id"
    t.string   "type"
    t.decimal  "amount",            :precision => 12, :scale => 2, :default => 0.0
    t.boolean  "success",                                          :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
