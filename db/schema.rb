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

ActiveRecord::Schema.define(:version => 20110721031820) do

  create_table "aclasses", :force => true do |t|
    t.string   "name",       :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adoptions", :force => true do |t|
    t.integer  "animal_id",        :null => false
    t.integer  "buyer_id",         :null => false
    t.date     "purchase_date",    :null => false
    t.string   "delivery_address", :null => false
    t.string   "payment_mode",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animals", :force => true do |t|
    t.string   "name",            :limit => 40, :null => false
    t.date     "birthdate"
    t.string   "gender",          :limit => 8
    t.float    "height"
    t.float    "weight"
    t.integer  "age"
    t.float    "value"
    t.string   "motto",           :limit => 80
    t.string   "acquisition"
    t.string   "img_url"
    t.text     "img_description"
    t.integer  "kingdom_id",                    :null => false
    t.integer  "phylum_id",                     :null => false
    t.integer  "aclass_id",                     :null => false
    t.integer  "aorder_id",                     :null => false
    t.integer  "family_id",                     :null => false
    t.integer  "genus_id",                      :null => false
    t.integer  "species_id",                    :null => false
    t.integer  "habitat_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "animals_events", :id => false, :force => true do |t|
    t.integer "animal_id", :null => false
    t.integer "event_id",  :null => false
  end

  create_table "animals_statuses", :id => false, :force => true do |t|
    t.integer "animal_id", :null => false
    t.integer "status_id", :null => false
  end

  create_table "aorders", :force => true do |t|
    t.string   "name",       :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buyers", :force => true do |t|
    t.string   "name",       :limit => 40,                        :null => false
    t.string   "contact_no",                                      :null => false
    t.string   "status",     :limit => 20, :default => "Pending", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "body",                                           :null => false
    t.integer  "post_id",                                        :null => false
    t.string   "status",     :limit => 20, :default => "Active", :null => false
    t.string   "author",     :limit => 40,                       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consumptions", :force => true do |t|
    t.integer  "food_id",                       :null => false
    t.integer  "maintenance_id",                :null => false
    t.integer  "qty_used",       :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "first_name",     :limit => 40, :null => false
    t.string   "middle_name"
    t.string   "last_name",      :limit => 40, :null => false
    t.string   "address",                      :null => false
    t.date     "birthdate",                    :null => false
    t.string   "gender",         :limit => 8,  :null => false
    t.string   "tel_no"
    t.string   "mob_no"
    t.float    "salary",                       :null => false
    t.date     "date_employed",                :null => false
    t.integer  "years_employed"
    t.string   "img_url"
    t.string   "employee_type",                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees_events", :id => false, :force => true do |t|
    t.integer "employee_id", :null => false
    t.integer "event_id",    :null => false
  end

  create_table "employees_maintenances", :id => false, :force => true do |t|
    t.integer "employee_id",    :null => false
    t.integer "maintenance_id", :null => false
  end

  create_table "employees_skills", :id => false, :force => true do |t|
    t.integer "employee_id", :null => false
    t.integer "skill_id",    :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name",            :limit => 40,                :null => false
    t.text     "description"
    t.integer  "capacity",                      :default => 1, :null => false
    t.string   "img_url"
    t.text     "img_description"
    t.integer  "habitat_id",                                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "families", :force => true do |t|
    t.string   "name",       :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foods", :force => true do |t|
    t.string   "name",        :limit => 40, :null => false
    t.text     "description"
    t.integer  "qty_on_hand",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genus", :force => true do |t|
    t.string   "name",       :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "habitat_types", :force => true do |t|
    t.string   "name",        :limit => 40, :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "habitats", :force => true do |t|
    t.string   "name",            :limit => 40,                :null => false
    t.integer  "animals_count",                 :default => 0
    t.integer  "max_occupants",                                :null => false
    t.string   "img_url"
    t.text     "img_description"
    t.text     "description"
    t.integer  "habitat_type_id",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kingdoms", :force => true do |t|
    t.string   "name",       :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maintenances", :force => true do |t|
    t.integer  "habitat_id",       :null => false
    t.date     "maintenance_date"
    t.time     "maintenance"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "map_areas", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.integer  "x1",          :null => false
    t.integer  "x2",          :null => false
    t.integer  "y1",          :null => false
    t.integer  "y2",          :null => false
    t.integer  "zoomap_id",   :null => false
    t.integer  "habitat_id",  :null => false
    t.string   "img_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performances", :force => true do |t|
    t.integer  "event_id",                      :null => false
    t.date     "event_date",                    :null => false
    t.time     "event_start",                   :null => false
    t.time     "event_end",                     :null => false
    t.integer  "no_of_visitors", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phylums", :force => true do |t|
    t.string   "name",       :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.string   "title",           :limit => 40,                        :null => false
    t.text     "body",                                                 :null => false
    t.string   "status",          :limit => 20, :default => "Pending", :null => false
    t.string   "author",          :limit => 40,                        :null => false
    t.string   "img_url"
    t.text     "img_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", :force => true do |t|
    t.string   "name",       :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "species", :force => true do |t|
    t.string   "name",       :limit => 40, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsors", :force => true do |t|
    t.string   "name",              :limit => 40,                        :null => false
    t.string   "contact_no",                                             :null => false
    t.integer  "sponsorship_level",                                      :null => false
    t.string   "status",            :limit => 20, :default => "Pending", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsorships", :force => true do |t|
    t.integer  "animal_id",    :null => false
    t.integer  "sponsor_id",   :null => false
    t.date     "sponsor_date", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", :force => true do |t|
    t.string   "name",        :limit => 40, :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscribers", :force => true do |t|
    t.string   "first_name", :limit => 40,                        :null => false
    t.string   "last_name",  :limit => 40,                        :null => false
    t.string   "email",                                           :null => false
    t.string   "contact_no"
    t.string   "status",     :limit => 20, :default => "Pending", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "employee_id",               :null => false
    t.string   "username",    :limit => 16, :null => false
    t.string   "password",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zoomaps", :force => true do |t|
    t.string   "name",                                                :null => false
    t.text     "description"
    t.string   "img_url",                                             :null => false
    t.text     "img_description"
    t.string   "status",          :limit => 20, :default => "Active", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
