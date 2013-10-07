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

ActiveRecord::Schema.define(version: 20131006231317) do

  create_table "bash_machines", force: true do |t|
    t.integer  "bash_id"
    t.integer  "machine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bash_machines", ["bash_id"], name: "index_bash_machines_on_bash_id"
  add_index "bash_machines", ["machine_id"], name: "index_bash_machines_on_machine_id"

  create_table "bashes", force: true do |t|
    t.string   "file"
    t.binary   "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "file_path"
  end

  create_table "boxes", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chef_jsons", force: true do |t|
    t.integer  "chef_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chef_jsons", ["chef_id"], name: "index_chef_jsons_on_chef_id"

  create_table "chef_machines", force: true do |t|
    t.integer  "chef_id"
    t.integer  "machine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chef_machines", ["chef_id"], name: "index_chef_machines_on_chef_id"
  add_index "chef_machines", ["machine_id"], name: "index_chef_machines_on_machine_id"

  create_table "chefs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cookbook_name"
    t.string   "databag_name"
    t.string   "databag_path"
    t.string   "cookbook_path"
  end

  create_table "keys", force: true do |t|
    t.string   "private"
    t.string   "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "private_path"
    t.string   "public_path"
  end

  create_table "machines", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "box_id"
    t.integer  "network_id"
    t.integer  "key_id"
    t.integer  "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "port"
    t.text     "log"
  end

  add_index "machines", ["box_id"], name: "index_machines_on_box_id"
  add_index "machines", ["key_id"], name: "index_machines_on_key_id"
  add_index "machines", ["network_id"], name: "index_machines_on_network_id"
  add_index "machines", ["status_id"], name: "index_machines_on_status_id"

  create_table "networks", force: true do |t|
    t.string   "name"
    t.string   "bridge"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "puppet_facts", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.text     "value"
    t.integer  "puppet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "puppet_facts", ["puppet_id"], name: "index_puppet_facts_on_puppet_id"

  create_table "puppet_machines", force: true do |t|
    t.integer  "puppet_id"
    t.integer  "machine_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "puppet_machines", ["machine_id"], name: "index_puppet_machines_on_machine_id"
  add_index "puppet_machines", ["puppet_id"], name: "index_puppet_machines_on_puppet_id"

  create_table "puppet_options", force: true do |t|
    t.string   "name"
    t.text     "option"
    t.integer  "puppet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "puppet_options", ["puppet_id"], name: "index_puppet_options_on_puppet_id"

  create_table "puppets", force: true do |t|
    t.string   "name"
    t.binary   "manifest_file"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "manifest_filename"
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
