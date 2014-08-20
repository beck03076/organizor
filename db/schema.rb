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

ActiveRecord::Schema.define(:version => 20140730075100) do

  create_table "allow_ips", :force => true do |t|
    t.string   "from"
    t.string   "to"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "application_statuses", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
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
    t.boolean  "checked"
    t.integer  "receiver_id"
    t.text     "meta"
    t.string   "title"
  end

  add_index "audits", ["associated_id", "associated_type"], :name => "associated_index"
  add_index "audits", ["auditable_id", "auditable_type"], :name => "auditable_index"
  add_index "audits", ["created_at"], :name => "index_audits_on_created_at"
  add_index "audits", ["user_id", "user_type"], :name => "user_index"

  create_table "branches", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "city_id"
    t.integer  "country_id"
    t.string   "email"
    t.string   "phone"
    t.string   "fax"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_post_code"
    t.string   "image"
    t.integer  "managed_by"
  end

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

  create_table "commission_claim_statuses", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "commission_statuses", :force => true do |t|
    t.string   "name"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "desc"
  end

  create_table "commissions", :force => true do |t|
    t.integer  "status_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "currency"
    t.integer  "fee_id"
    t.integer  "paid_cents"
    t.integer  "remaining_cents"
  end

  create_table "contact_types", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "cl"
  end

  create_table "contract_doc_categories", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contracts", :force => true do |t|
    t.string   "name"
    t.date     "initiate_date"
    t.string   "current_contract_start_date"
    t.string   "current_contract_end_date"
    t.date     "renewal_reminder_date"
    t.string   "commission_rate"
    t.string   "invoicing_deadline"
    t.string   "partners_target"
    t.string   "internal_target"
    t.string   "recruitment_territories"
    t.text     "desc"
    t.integer  "institution_id"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "commission_specified"
    t.boolean  "territory_specified"
    t.integer  "notes_count",                 :default => 0, :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.string   "code"
    t.string   "continent",       :limit => 13, :default => "Asia"
    t.string   "region"
    t.string   "government_form"
    t.string   "local_name"
    t.integer  "capital_city_id"
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.integer  "region_id"
  end

  create_table "course_levels", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "course_levels_sliding_scales", :force => true do |t|
    t.integer  "course_level_id"
    t.integer  "sliding_scale_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "course_subjects", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "currencies", :force => true do |t|
    t.string   "iso_alpha2"
    t.string   "iso_alpha3"
    t.integer  "iso_numeric"
    t.string   "code"
    t.string   "name"
    t.string   "symbol"
    t.string   "country_name"
    t.integer  "country_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "doc_categories", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.integer  "category_id"
    t.integer  "registration_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "contract_id"
    t.integer  "contract_category_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "doc_type"
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
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "smtp_id"
    t.text     "signature"
    t.boolean  "auto"
    t.string   "core"
  end

  create_table "emails_enquiries", :force => true do |t|
    t.integer  "email_id"
    t.integer  "enquiry_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "emails_institutions", :force => true do |t|
    t.integer  "email_id"
    t.integer  "institution_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "emails_people", :force => true do |t|
    t.integer  "email_id"
    t.integer  "person_id"
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
    t.string   "email"
    t.string   "alternate_email"
    t.string   "gender"
    t.date     "date_of_birth"
    t.integer  "score"
    t.integer  "assigned_to"
    t.integer  "assigned_by"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "country_id"
    t.integer  "status_id"
    t.text     "address"
    t.boolean  "active",            :default => true
    t.integer  "contact_type_id"
    t.boolean  "registered",        :default => false
    t.string   "image"
    t.integer  "branch_id"
    t.date     "registered_at"
    t.integer  "registered_by"
    t.integer  "impressions_count"
    t.string   "response_time"
    t.datetime "assigned_at"
    t.string   "conversion_time"
    t.integer  "emails_count",      :default => 0,     :null => false
    t.integer  "follow_ups_count",  :default => 0,     :null => false
    t.integer  "todos_count",       :default => 0,     :null => false
    t.integer  "notes_count",       :default => 0,     :null => false
    t.integer  "student_source_id"
    t.boolean  "direct"
    t.integer  "sub_agent_id"
  end

  add_index "enquiries", ["assigned_by"], :name => "index_enquiries_on_assigned_by"
  add_index "enquiries", ["assigned_to"], :name => "index_enquiries_on_assigned_to"
  add_index "enquiries", ["branch_id"], :name => "index_enquiries_on_branch_id"
  add_index "enquiries", ["contact_type_id"], :name => "index_enquiries_on_contact_type_id"
  add_index "enquiries", ["country_id"], :name => "index_enquiries_on_country_id"
  add_index "enquiries", ["created_by"], :name => "index_enquiries_on_created_by"
  add_index "enquiries", ["first_name"], :name => "index_enquiries_on_first_name"
  add_index "enquiries", ["registered_by"], :name => "index_enquiries_on_registered_by"
  add_index "enquiries", ["status_id"], :name => "index_enquiries_on_status_id"
  add_index "enquiries", ["student_source_id"], :name => "index_enquiries_on_student_source_id"
  add_index "enquiries", ["sub_agent_id"], :name => "index_enquiries_on_sub_agent_id"
  add_index "enquiries", ["updated_by"], :name => "index_enquiries_on_updated_by"

  create_table "enquiry_statuses", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "cl"
  end

  create_table "event_types", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
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
    t.integer  "eng_level_id"
  end

  create_table "fees", :force => true do |t|
    t.integer  "tuition_fee_cents"
    t.string   "commission_percentage"
    t.integer  "commission_amount_cents"
    t.integer  "programme_id"
    t.string   "currency"
    t.integer  "scholarship_cents"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.date     "first_payment_date"
    t.date     "invoice_date"
    t.integer  "commission_paid_cents"
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
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "assigned_to"
    t.integer  "assigned_by"
    t.boolean  "followed"
    t.boolean  "auto"
    t.datetime "followed_at"
    t.string   "follow_upable_type"
    t.integer  "follow_upable_id"
  end

  create_table "images", :force => true do |t|
    t.string   "path"
    t.string   "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "impressions", :force => true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], :name => "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], :name => "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], :name => "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], :name => "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], :name => "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], :name => "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], :name => "impressionable_type_message_index", :length => {"impressionable_type"=>nil, "message"=>255, "impressionable_id"=>nil}
  add_index "impressions", ["user_id"], :name => "index_impressions_on_user_id"

  create_table "institution_groups", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "institution_types", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "educational"
  end

  create_table "institutions", :force => true do |t|
    t.string   "name"
    t.integer  "city_id"
    t.integer  "country_id"
    t.integer  "type_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email"
    t.string   "phone"
    t.string   "fax"
    t.string   "website"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_post_code"
    t.string   "image"
    t.text     "desc"
    t.integer  "person_id"
    t.integer  "group_id"
    t.integer  "assigned_to"
    t.integer  "assigned_by"
    t.datetime "assigned_at"
    t.integer  "impressions_count"
    t.string   "response_time"
    t.integer  "notes_count",            :default => 0,  :null => false
    t.integer  "todos_count",            :default => 0,  :null => false
    t.integer  "follow_ups_count",       :default => 0,  :null => false
    t.integer  "emails_count",           :default => 0,  :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "last_seen_at"
  end

  add_index "institutions", ["assigned_by"], :name => "index_institutions_on_assigned_by"
  add_index "institutions", ["assigned_to"], :name => "index_institutions_on_assigned_to"
  add_index "institutions", ["country_id"], :name => "index_institutions_on_country_id"
  add_index "institutions", ["created_by"], :name => "index_institutions_on_created_by"
  add_index "institutions", ["name"], :name => "index_institutions_on_name"
  add_index "institutions", ["reset_password_token"], :name => "index_institutions_on_reset_password_token", :unique => true
  add_index "institutions", ["updated_by"], :name => "index_institutions_on_updated_by"

  create_table "institutions_permissions", :force => true do |t|
    t.integer  "institution_id"
    t.integer  "permission_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "notes", :force => true do |t|
    t.text     "content"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.boolean  "auto"
    t.string   "noteable_type"
    t.integer  "noteable_id"
    t.integer  "assigned_to"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "surname"
    t.string   "mobile"
    t.string   "email"
    t.string   "work_phone"
    t.string   "home_phone"
    t.date     "date_of_birth"
    t.string   "gender"
    t.string   "address_line1"
    t.string   "address_line2"
    t.integer  "city_id"
    t.integer  "country_id"
    t.string   "address_post_code"
    t.string   "image"
    t.string   "skype"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "twitter"
    t.string   "gplus"
    t.string   "blogger"
    t.string   "website"
    t.text     "desc"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "institution_id"
    t.integer  "type_id"
    t.integer  "assigned_to"
    t.integer  "assigned_by"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "job_title"
    t.datetime "assigned_at"
    t.integer  "impressions_count"
    t.string   "response_time"
    t.integer  "notes_count",       :default => 0, :null => false
    t.integer  "todos_count",       :default => 0, :null => false
    t.integer  "follow_ups_count",  :default => 0, :null => false
    t.integer  "emails_count",      :default => 0, :null => false
    t.boolean  "sub_agent"
  end

  add_index "people", ["assigned_by"], :name => "index_people_on_assigned_by"
  add_index "people", ["assigned_to"], :name => "index_people_on_assigned_to"
  add_index "people", ["country_id"], :name => "index_people_on_country_id"
  add_index "people", ["created_by"], :name => "index_people_on_created_by"
  add_index "people", ["first_name"], :name => "index_people_on_first_name"
  add_index "people", ["updated_by"], :name => "index_people_on_updated_by"

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

  create_table "permissions_registrations", :force => true do |t|
    t.integer  "permission_id"
    t.integer  "registration_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
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

  create_table "permitted_countries", :force => true do |t|
    t.integer  "country_id"
    t.integer  "contract_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "permitted_regions", :force => true do |t|
    t.integer  "region_id"
    t.integer  "contract_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "person_types", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "preferred_countries", :force => true do |t|
    t.integer  "country_id"
    t.integer  "enquiry_id"
    t.integer  "priority"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "processing_fee_statuses", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "processing_fee_types", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "proficiencies", :force => true do |t|
    t.integer  "prof_eng_level_id"
    t.integer  "prof_exam_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
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
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "app_status_id"
    t.integer  "ins_ref_no"
    t.integer  "registration_id"
    t.string   "course_subject_text"
    t.integer  "claim_status_id"
    t.integer  "p_fee_id"
    t.integer  "p_fee_cents"
    t.string   "currency"
    t.integer  "p_fee_status_id"
    t.text     "p_fee_bank_details"
    t.string   "conversion_time"
    t.integer  "notes_count",         :default => 0, :null => false
  end

  create_table "progression_statuses", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "prohibited_countries", :force => true do |t|
    t.integer  "country_id"
    t.integer  "contract_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "prohibited_regions", :force => true do |t|
    t.integer  "region_id"
    t.integer  "contract_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
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

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "registrations", :force => true do |t|
    t.string   "ref_no"
    t.string   "first_name"
    t.string   "surname"
    t.string   "gender"
    t.date     "date_of_birth"
    t.integer  "country_id"
    t.string   "email"
    t.string   "alternate_email"
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
    t.string   "qua_subject"
    t.string   "qua_institution"
    t.string   "qua_grade"
    t.string   "qua_exam"
    t.string   "qua_score"
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.text     "note"
    t.integer  "enquiry_id"
    t.string   "image"
    t.integer  "branch_id"
    t.integer  "progression_status_id"
    t.datetime "assigned_at"
    t.string   "response_time"
    t.integer  "impressions_count"
    t.string   "conversion_time"
    t.integer  "notes_count",            :default => 0,  :null => false
    t.integer  "todos_count",            :default => 0,  :null => false
    t.integer  "follow_ups_count",       :default => 0,  :null => false
    t.integer  "emails_count",           :default => 0,  :null => false
    t.integer  "contact_type_id"
    t.integer  "student_source_id"
    t.boolean  "direct"
    t.integer  "qualification_id"
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "last_seen_at"
  end

  add_index "registrations", ["assigned_by"], :name => "index_registrations_on_assigned_by"
  add_index "registrations", ["assigned_to"], :name => "index_registrations_on_assigned_to"
  add_index "registrations", ["branch_id"], :name => "index_registrations_on_branch_id"
  add_index "registrations", ["confirmation_token"], :name => "index_registrations_on_confirmation_token", :unique => true
  add_index "registrations", ["contact_type_id"], :name => "index_registrations_on_contact_type_id"
  add_index "registrations", ["country_id"], :name => "index_registrations_on_country_id"
  add_index "registrations", ["created_by"], :name => "index_registrations_on_created_by"
  add_index "registrations", ["email"], :name => "index_registrations_on_email1", :unique => true
  add_index "registrations", ["enquiry_id"], :name => "index_registrations_on_enquiry_id"
  add_index "registrations", ["first_name"], :name => "index_registrations_on_first_name"
  add_index "registrations", ["progression_status_id"], :name => "index_registrations_on_progression_status_id"
  add_index "registrations", ["qualification_id"], :name => "index_registrations_on_qualification_id"
  add_index "registrations", ["reset_password_token"], :name => "index_registrations_on_reset_password_token", :unique => true
  add_index "registrations", ["student_source_id"], :name => "index_registrations_on_student_source_id"
  add_index "registrations", ["sub_agent_id"], :name => "index_registrations_on_sub_agent_id"
  add_index "registrations", ["updated_by"], :name => "index_registrations_on_updated_by"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "desc"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "saved_reports", :force => true do |t|
    t.string   "name"
    t.text     "q"
    t.integer  "created_by"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "heading"
    t.string   "module"
  end

  create_table "sliding_ranges", :force => true do |t|
    t.integer  "from"
    t.integer  "to"
    t.string   "commission_percentage"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "sliding_ranges_sliding_scales", :force => true do |t|
    t.integer  "sliding_scale_id"
    t.integer  "sliding_range_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "sliding_scales", :force => true do |t|
    t.integer  "course_level_id"
    t.string   "commission_percentage"
    t.integer  "contract_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "second_year"
    t.string   "third_year"
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
    t.text     "desc"
  end

  create_table "status_diagrams", :force => true do |t|
    t.integer  "status_id"
    t.integer  "user_id"
    t.integer  "programme_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "status_name"
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
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "cl"
    t.integer  "contact_type_id"
  end

  create_table "timelines", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_name"
    t.datetime "created_at",                     :null => false
    t.text     "desc"
    t.string   "a_name"
    t.integer  "a_id"
    t.datetime "updated_at",                     :null => false
    t.text     "comment"
    t.string   "action"
    t.integer  "m_id"
    t.string   "m_name"
    t.boolean  "checked",     :default => false
    t.integer  "receiver_id"
  end

  create_table "todo_topics", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
    t.text     "api_id"
  end

  create_table "todos", :force => true do |t|
    t.integer  "topic_id"
    t.text     "desc"
    t.datetime "duedate"
    t.string   "priority"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "assigned_to"
    t.integer  "assigned_by"
    t.boolean  "done",          :default => false
    t.boolean  "api"
    t.datetime "done_at"
    t.string   "title"
    t.text     "api_id"
    t.boolean  "auto"
    t.string   "todoable_type"
    t.integer  "todoable_id"
  end

  create_table "typeaheads", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_configs", :force => true do |t|
    t.integer  "def_follow_up_days"
    t.integer  "user_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
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
    t.string   "def_ins_search_col"
    t.text     "ins_cols"
    t.string   "def_per_search_col"
    t.text     "per_cols"
    t.string   "def_pro_search_col"
    t.text     "pro_cols"
    t.integer  "def_progression_fu_ass_to"
  end

  create_table "users", :force => true do |t|
    t.integer  "branch_id"
    t.integer  "role_id"
    t.string   "image"
    t.text     "email_signature"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
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
    t.string   "skype"
    t.string   "facebook"
    t.string   "linkedin"
    t.string   "twitter"
    t.string   "website"
    t.string   "gplus"
    t.string   "blogger"
    t.boolean  "is_active"
    t.datetime "last_seen_at"
    t.integer  "country_id"
    t.string   "userable_type"
    t.integer  "userable_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token", :unique => true
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
