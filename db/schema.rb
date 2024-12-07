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

ActiveRecord::Schema.define(:version => 20221006121209) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "admin_name"
    t.boolean  "locked",                 :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "announce_to_parents", :force => true do |t|
    t.integer  "school_id"
    t.string   "title"
    t.text     "description"
    t.text     "body"
    t.string   "youtube"
    t.date     "news_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "announce_to_parents", ["school_id"], :name => "index_announce_to_parents_on_school_id"

  create_table "announcements", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "body"
    t.string   "youtube"
    t.text     "location"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "school_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "announcements", ["school_id"], :name => "index_announcements_on_school_id"

  create_table "ckeditor_assets", :force => true do |t|
    t.integer  "school_id",                       :null => false
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"
  add_index "ckeditor_assets", ["school_id"], :name => "index_ckeditor_assets_on_school_id"

  create_table "creations", :force => true do |t|
    t.integer  "school_id"
    t.string   "title"
    t.text     "description"
    t.text     "body"
    t.string   "youtube"
    t.date     "news_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "creations", ["school_id"], :name => "index_creations_on_school_id"

  create_table "districts", :force => true do |t|
    t.string "title"
  end

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "parent_page_id"
    t.string   "parent_page_type"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "findex", :force => true do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "school_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "findex", ["school_id"], :name => "index_findex_on_school_id"

  create_table "folders", :force => true do |t|
    t.string   "title"
    t.integer  "school_id"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "folders", ["school_id"], :name => "index_folders_on_school_id"

  create_table "foods", :force => true do |t|
    t.date     "date"
    t.integer  "menu_type"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "school_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "foods", ["school_id"], :name => "index_foods_on_school_id"

  create_table "global_pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "permalink"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "media_links", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "url_source"
    t.datetime "date_public"
    t.integer  "school_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "media_links", ["school_id"], :name => "index_media_links_on_school_id"

  create_table "methodic_documents", :force => true do |t|
    t.integer  "teacher_id"
    t.string   "title"
    t.text     "description"
    t.date     "date"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "methodic_documents", ["teacher_id"], :name => "index_methodic_documents_on_teacher_id"

  create_table "methodics", :force => true do |t|
    t.integer "school_id"
    t.string  "title"
    t.string  "full_title"
  end

  add_index "methodics", ["school_id"], :name => "index_methodics_on_school_id"

  create_table "news", :force => true do |t|
    t.integer  "school_id"
    t.string   "title"
    t.text     "description"
    t.text     "body"
    t.string   "youtube"
    t.boolean  "achiev_school"
    t.boolean  "achiev_section"
    t.boolean  "achiev_teacher"
    t.boolean  "achiev_pupil"
    t.date     "news_date"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "news", ["school_id"], :name => "index_news_on_school_id"

  create_table "news_links", :force => true do |t|
    t.integer "news_id"
    t.integer "link_id"
    t.string  "link_type"
  end

  add_index "news_links", ["news_id"], :name => "index_news_links_on_news_id"

  create_table "page_groups", :force => true do |t|
    t.integer  "school_id"
    t.string   "title"
    t.string   "content_type"
    t.boolean  "default",            :default => false
    t.integer  "number"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "published",          :default => true
  end

  add_index "page_groups", ["school_id"], :name => "index_page_groups_on_school_id"

  create_table "page_navigation_links", :force => true do |t|
    t.integer "page_group_id"
    t.string  "title"
    t.string  "link"
    t.boolean "default",       :default => false
    t.integer "number"
  end

  add_index "page_navigation_links", ["page_group_id"], :name => "index_page_navigation_links_on_page_group_id"

  create_table "photos", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "parent_of_image_id"
    t.string   "parent_of_image_type"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "school_index_images", :force => true do |t|
    t.integer  "school_id"
    t.string   "title"
    t.text     "body"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "school_index_images", ["school_id"], :name => "index_school_index_images_on_school_id"

  create_table "schools", :force => true do |t|
    t.integer  "district_id"
    t.string   "permalink",                          :default => "",    :null => false
    t.string   "title"
    t.text     "description"
    t.text     "text_about_page"
    t.float    "n_cordinate"
    t.float    "e_cordinate"
    t.string   "emblem_file_name"
    t.string   "emblem_content_type"
    t.integer  "emblem_file_size"
    t.datetime "emblem_updated_at"
    t.string   "mailto"
    t.string   "address",                            :default => ""
    t.string   "phones",                             :default => ""
    t.string   "other_contact",       :limit => 500, :default => ""
    t.string   "existing_site"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "vk"
    t.string   "facebook"
    t.string   "twitter"
    t.boolean  "archive",                            :default => false
    t.string   "pos_id"
  end

  add_index "schools", ["district_id"], :name => "index_schools_on_district_id"
  add_index "schools", ["permalink"], :name => "index_schools_on_permalink"

  create_table "sections", :force => true do |t|
    t.integer  "school_id"
    t.string   "title"
    t.string   "year"
    t.integer  "count"
    t.string   "description"
    t.text     "body"
    t.string   "type_of_section"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "sections", ["school_id"], :name => "index_sections_on_school_id"

  create_table "simply_links", :force => true do |t|
    t.string  "link_url"
    t.string  "link_title"
    t.integer "parent_link_page_id"
    t.string  "parent_link_page_type"
  end

  create_table "sponsors", :force => true do |t|
    t.string  "title"
    t.string  "sponsor_type"
    t.string  "sponsor_url"
    t.integer "school_id"
  end

  add_index "sponsors", ["school_id"], :name => "index_sponsors_on_school_id"

  create_table "static_pages", :force => true do |t|
    t.integer  "page_navigation_link_id"
    t.string   "title"
    t.text     "body"
    t.boolean  "default",                 :default => false
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "number"
  end

  add_index "static_pages", ["page_navigation_link_id"], :name => "index_static_pages_on_page_navigation_link_id"

  create_table "teacher_groups", :force => true do |t|
    t.string  "title"
    t.integer "school_id"
  end

  add_index "teacher_groups", ["school_id"], :name => "index_teacher_groups_on_school_id"

  create_table "teacher_methodic_links", :id => false, :force => true do |t|
    t.integer "teacher_id"
    t.integer "methodic_id"
  end

  add_index "teacher_methodic_links", ["methodic_id", "teacher_id"], :name => "index_teacher_methodic_links_on_methodic_id_and_teacher_id", :unique => true
  add_index "teacher_methodic_links", ["teacher_id", "methodic_id"], :name => "index_teacher_methodic_links_on_teacher_id_and_methodic_id", :unique => true

  create_table "teacher_section_links", :id => false, :force => true do |t|
    t.integer "teacher_id"
    t.integer "section_id"
  end

  add_index "teacher_section_links", ["section_id", "teacher_id"], :name => "index_teacher_section_links_on_section_id_and_teacher_id", :unique => true
  add_index "teacher_section_links", ["teacher_id", "section_id"], :name => "index_teacher_section_links_on_teacher_id_and_section_id", :unique => true

  create_table "teachers", :force => true do |t|
    t.string   "surname"
    t.string   "name"
    t.string   "experience"
    t.string   "clafication"
    t.string   "post"
    t.text     "about_teacher"
    t.text     "achiev"
    t.text     "contact"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "teacher_group_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "teachers", ["teacher_group_id"], :name => "index_teachers_on_teacher_group_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username",               :default => "",    :null => false
    t.boolean  "root",                   :default => false
    t.boolean  "locked",                 :default => false
    t.integer  "school_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["school_id"], :name => "index_users_on_school_id"

end
