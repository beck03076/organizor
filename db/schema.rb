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

ActiveRecord::Schema.define(:version => 20131023164805) do

  create_table "application_statuses", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "audits", :force => true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         :default => 0
    t.string   "comment"
    t.string   "remote_address"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "cities", :force => true do |t|
    t.string   "country_code"
    t.string   "name"
    t.text     "desc"
    t.integer  "country_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "contact_types", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.string   "code"
    t.string   "continent"
    t.string   "region"
    t.string   "government_form"
    t.string   "local_name"
    t.integer  "capital_city_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "course_levels", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "course_subjects", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "doc_categories", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.integer  "category_id"
    t.integer  "registration_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "email_templates", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.text     "subject"
    t.text     "body"
    t.text     "signature"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "emails", :force => true do |t|
    t.text     "to"
    t.text     "from"
    t.text     "cc"
    t.text     "bcc"
    t.text     "subject"
    t.text     "body"
    t.string   "attachment"
    t.integer  "user_id"
    t.integer  "enquiry_id"
    t.integer  "registration_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "smtp_id"
    t.text     "signature"
  end

  create_table "emails_enquiries", :force => true do |t|
    t.integer  "email_id"
    t.integer  "enquiry_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "emails_registrations", :force => true do |t|
    t.integer  "registration_id"
    t.integer  "email_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "english_levels", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "enquiries", :force => true do |t|
    t.string   "first_name"
    t.string   "surname"
    t.string   "mobile1"
    t.string   "mobile2"
    t.string   "email1"
    t.string   "email2"
    t.string   "gender"
    t.date     "date_of_birth"
    t.integer  "score"
    t.integer  "source_id"
    t.integer  "assigned_to"
    t.integer  "assigned_by"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "country_id"
    t.integer  "status_id"
    t.text     "address"
    t.boolean  "active",          :default => true
    t.integer  "contact_type_id"
  end

  create_table "enquiry_sources", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "enquiry_statuses", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exam_scores", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exam_types", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exams", :force => true do |t|
    t.date     "exam_date"
    t.integer  "exam_type_id"
    t.string   "exam_score"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "registration_id"
  end

  create_table "follow_ups", :force => true do |t|
    t.string   "title"
    t.text     "desc"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean  "api"
    t.integer  "event_type_id"
    t.string   "venue"
    t.integer  "remind_before"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "enquiry_id"
    t.integer  "assigned_to"
    t.integer  "assigned_by"
    t.integer  "registration_id"
  end

  create_table "images", :force => true do |t|
    t.string   "path"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "institutions", :force => true do |t|
    t.string   "name"
    t.integer  "type_id"
    t.integer  "city_id"
    t.integer  "country_id"
    t.integer  "poc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notes", :force => true do |t|
    t.text     "content"
    t.string   "sub_class"
    t.integer  "sub_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "permissions", :force => true do |t|
    t.string   "name"
    t.string   "subject_class"
    t.integer  "subject_id"
    t.string   "action"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "subject_var"
  end

  create_table "permissions_roles", :force => true do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "permissions_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "permission_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "preferred_countries", :force => true do |t|
    t.integer  "country_id"
    t.integer  "enquiry_id"
    t.integer  "priority"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "proficiencies", :force => true do |t|
    t.integer  "prof_eng_level_id"
    t.integer  "prof_exam_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "programme_types", :force => true do |t|
    t.string   "name"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "programmes", :force => true do |t|
    t.integer  "type_id"
    t.integer  "country_id"
    t.integer  "city_id"
    t.integer  "institution_id"
    t.integer  "level_id"
    t.integer  "subject_id"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "enquiry_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "course_subject"
    t.integer  "app_status_id"
    t.integer  "ins_ref_no"
    t.integer  "registration_id"
    t.string   "course_subject_text"
  end

  create_table "qualifications", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reg_courses", :force => true do |t|
    t.integer  "city_id"
    t.integer  "country_id"
    t.integer  "institution_id"
    t.integer  "course_level_id"
    t.string   "course_subject"
    t.integer  "programme_type_id"
    t.integer  "app_status_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "ins_ref_no"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "registration_id"
  end

  create_table "registrations", :force => true do |t|
    t.string   "ref_no"
    t.string   "first_name"
    t.string   "surname"
    t.string   "gender"
    t.date     "date_of_birth"
    t.integer  "country_id"
    t.string   "email1"
    t.string   "email2"
    t.string   "mobile1"
    t.string   "mobile2"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_city"
    t.integer  "address_country_id"
    t.string   "address_post_code"
    t.string   "address_others"
    t.string   "passport_number"
    t.date     "passport_valid_till"
    t.string   "visa_type"
    t.date     "visa_valid_till"
    t.integer  "qua_id"
    t.string   "qua_subject"
    t.string   "qua_institution"
    t.string   "qua_grade"
    t.string   "qua_exam"
    t.string   "qua_score"
    t.integer  "course_id"
    t.integer  "reg_source_id"
    t.boolean  "reg_direct"
    t.string   "reg_came_through"
    t.integer  "sub_agent_id"
    t.string   "emer_full_name"
    t.string   "emer_relationship"
    t.string   "emer_mobile"
    t.string   "emer_email"
    t.string   "flight_no"
    t.date     "flight_arrival_date"
    t.time     "flight_arrival_time"
    t.string   "flight_airport"
    t.integer  "assigned_to"
    t.integer  "assigned_by"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "prof_eng_level_id"
    t.integer  "prof_exam_id"
    t.text     "note"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "smtps", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "port"
    t.string   "domain"
    t.string   "user_name"
    t.string   "password"
    t.string   "authentication"
    t.integer  "enable_starttls_auto"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "student_sources", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "contact_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sub_agents", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "contact_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "timelines", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_name"
    t.datetime "created_at", :null => false
    t.text     "desc"
    t.string   "a_name"
    t.integer  "a_id"
    t.datetime "updated_at", :null => false
    t.text     "comment"
    t.string   "action"
    t.integer  "m_id"
    t.string   "m_name"
  end

  create_table "todo_statuses", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "todo_topics", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "todos", :force => true do |t|
    t.integer  "topic_id"
    t.text     "desc"
    t.integer  "status_id"
    t.datetime "duedate"
    t.string   "priority"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "enquiry_id"
    t.integer  "assigned_to"
    t.integer  "assigned_by"
    t.integer  "registration_id"
    t.boolean  "done"
  end

  create_table "user_configs", :force => true do |t|
    t.integer  "def_follow_up_days"
    t.integer  "user_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.text     "def_note"
    t.text     "reg_cols"
    t.text     "enq_cols"
    t.string   "def_enq_email"
    t.string   "def_reg_email"
    t.string   "def_create_enquiry_email"
    t.string   "def_from_email"
    t.string   "def_f_u_name"
    t.text     "def_f_u_desc"
    t.integer  "def_f_u_type"
    t.boolean  "auto_cr_f_u"
    t.boolean  "auto_email_enq"
    t.integer  "def_f_u_ass_to"
    t.string   "def_enq_search_col"
    t.string   "def_reg_search_col"
  end

  create_table "users", :force => true do |t|
    t.integer  "branch_id"
    t.integer  "role_id"
    t.text     "email_signature"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "surname"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "mobile"
    t.string   "gender"
    t.date     "date_of_birth"
    t.text     "address"
    t.string   "image"
    t.string   "skype"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "twitter"
    t.string   "website"
    t.string   "gplus"
    t.string   "blogger"
    t.boolean  "is_active"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
