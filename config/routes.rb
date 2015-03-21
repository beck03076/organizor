require 'sidekiq/web'
Organizor::Application.routes.draw do
  get 'crop/:doc_id' => 'documents#crop'

  get 'joined_students' => "registrations#index"

  get 'web_enquiries' => "enquiries#index"

  resources :courses

  match '/configurations' => 'configurations#index', via: :get

  match '/edit_configuration/:model_name/:id' => "secondaries#edit", via: :get

  match '/show_configuration/:model_name/:id' => "secondaries#show", via: :get

  match '/secondaries/:model_name' => 'secondaries#index', via: :get

  match '/secondaries/:model_name' => 'secondaries#create', via: :post

  match '/secondaries/:model_name/:id' => 'secondaries#update', via: :put

  match '/secondaries/:model_name/:id' => 'secondaries#destroy', via: :delete

  match '/document/edit/:id' => "documents#edit"

  match '/approve_requests/:registration_id' => 'approve_requests#update', via: :put

  match '/approval' => 'approve_requests#approve_or_reject', via: [:get, :post], as: :approval

  match '/approve_requests/:id' => 'approve_requests#delete', via: :delete

  mount Sidekiq::Web => '/sidekiq'

  devise_for :partners, :controllers => {registrations: "partners", confirmations: "partner_confirmations" }
  as :partner do
      match '/partner/confirmation' => 'partner_confirmations#update', :via => :put, :as => :update_partner_confirmation
  end

  devise_for :registrations, :controllers => {registrations: "registrations", confirmations: "registration_confirmations" }
  as :registration do
      match '/registration/confirmation' => 'registration_confirmations#update', :via => :put, :as => :update_registration_confirmation
  end
 # get "partners/index"
  resources :registrations do
      collection { post :search, to: 'registrations#index' }
      member do
        get :clone
      end
  end

  resources :required_docs
  resources :required_doc_types

  # match '/typeaheads/:models/:col/:q' => 'typeaheads#results', format: false, constraints: { q: /[^\/]+/ }
  match '/typeaheads/:q' => 'typeaheads#results', format: false, constraints: { q: /[^\/]+/ }
  match '/analytics' => "analytics#index", as: "analytics"
  match "/analytics/:core/:core_method/:core_params" => "analytics#show"

  post '/compare_users_modal' => 'user_metrics#compare_users_modal'
  post '/compare_users' => 'user_metrics#compare_users'

  post '/save_report' => 'reports#save_report'

  resources :saved_reports

  match "/reports/users/:module/:uids(/:tab)" => "user_metrics#index"

  post '/partial_pie' => "reports#partial_pie"
  post '/partial_bar' => "reports#partial_bar"

  match '/reports/core_modules/:module' => "reports#show"
  match '/reports/charts/:module' => "reports#charts"
  match '/reports/users/:module' => "reports#show"

  match '/reports' => "reports#index", as: "reports"

  post '/filter_reports' => "reports#show", as: "filter_reports"

  match '/500' => 'handle#e_500'
  match '/404' => 'handle#e_500'
  match '/422' => 'handle#e_500'

  match '/users/:id/log' => "users#log"

  resources :processing_fee_statuses

  resources :processing_fee_types

  resources :progression_statuses

  resources :commission_claim_statuses

  resources :exams

  get '/unchecked_notys' => "application#unchecked_notys"
  get '/limited_notifications' => "application#limited_notifications"
  post '/set_checked_true' => "application#set_checked_true"
  post '/set_all_checked_true' => "application#set_all_checked_true"
  match "/all_notifications" => "application#all_notifications"

  get '/export_details/:model/:ids.:format' => 'application#export_details'

  get "/show/:volume/:model/:col/:id" => "programmes#show_full"

  get 'create_p_fee/:programme_id' => "programmes#create_p_fee"

  get '/get_currency/:country_id' => "json#currency"

  get '/user_configs/edit_prog_fu_ass_to' => 'user_configs#edit_prog_fu_ass_to'

  post '/partial_fee' => "commissions#partial_fee"

  get '/programmes/abc' => "programmes#abc"

  get '/programmes/ins_id/:ins_id/prog_ids/:prog_ids/export' => "programmes#index"

  post '/update_comm_claim/programmes' => 'programmes#update_comm_claim'

  post 'bulk_asso_update' => 'application#bulk_asso_update'

  post '/sliding_scales/collective' => 'sliding_scales#collective'

  post '/fetch_contract' => "commissions#fetch_contract"

  resources :fees

  resources :branches

  match '/partner_programmes/:partner_id.json' => "programmes#index"

  get 'create_fee/:programme_id' => "fees#create_fee"

  get 'emails/:id' => "emails#show"

  post '/emails/filter' => "emails#filter"

  get '/search/:model/:col/token.json' => "application#token_search"

  get '/get_column_names/:model/:filter' => "application#get_column_names"

  post '/filter_tasks' => 'tasks#index'

  match '/filter_users/:model(/:f_id)' => "users#index"

  match '/user_configs/manage/:partial' => 'user_configs#manage'

  # this url will be hit once the google authentication is succesful
  match '/auth/:provider/callback' => 'application#determine_redirect'

  match '/tasks/google_create' => "tasks#google_create"

  match '/tasks/start_sync' => "tasks#start_sync"

  match '/tasks/google_sync' => "tasks#google_sync"

  resources :allow_ips

  get "white_list/index", as: "banned"

# this url will be hit once the google authentication is succesful
#  match "/contacts/:importer/callback" => "import#contacts"
# this url will be hit once the google authentication is succesful
 # get '/auth/:provider/callback' => 'import#contacts'

  get '/import_contacts/:from' => "import#start"
  resources :commission_statuses

  resources :commissions

  match '/validate_recruit/:ins_id/:form_country_id(/:model/:item_id)' => 'application#validate_recruit'

  match '/srch_countries.json' => 'json#srch_countries'

  match '/srch_regions.json' => 'json#srch_regions'

#  match '/partner_type/:type_id' => 'json#partner_type'

  match '/get_users/:branch_id' => 'json#get_users'

  match "/people/tab/:status/:partial(/:person_id)" => "people#tab"

  resources :person_types

  resources :contract_doc_categories

  resources :partner_groups

  match "/partners/tab/:status/:partial(/:partner_id)" => "partners#tab"

  resources :partner_types

  resources :contracts

  get "resources/index"

  get "handle/error"

  get "handle/cancan"

  resources :documents do
      collection do
        delete :delete
      end
  end

  match '/cal_click/:start(/:end)' => 'follow_ups#cal_click'

  match "/show_browser/:id/:disposition" => "documents#show"

  match "/documents/delete_or_download" => "documents#delete_or_download"

  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  resources :smtps

  resources :roles

  resources :doc_categories

  resources :images

  resources :task_statuses

  resources :contact_types

  resources :task_topics

  resources :tasks

  resources :notes

  resources :event_types

  resources :follow_ups

  resources :emails

  match "/all_notifications" => "application#all_notifications"

  match "/email_sent_by/:sent_by" => "emails#index"

  match "/calendar_user/:user_id" => "follow_ups#index"

  match "/task_assigned_to/:ass_to" => "tasks#index"

  match "/task_assigned_by/:ass_by" => "tasks#index"

  match "/email_hover/:id" => "emails#show_hover"

  match "/follow_up_hover/:id" => "follow_ups#show_hover"

  match "/task_hover/:id" => "tasks#show_hover"

  match '/permissions/role/:role_id' => "roles#show_permissions"

  match '/bulk_email/:model/:model_ids' => "emails#bulk_email"

  match '/group_assign/:model/:model_ids/branch/:branch_id/user/:user_id' => "application#group_assign"

  match '/group_delete/:model/:model_ids' => "application#group_delete"

  match "/enquiries/tab/:status/:partial(/:enquiry_id)" => "enquiries#tab"

  match "/registrations/tab/:status/:partial(/:registration_id)" => "registrations#tab"

 match "/register/tab/:status/:partial/:enquiry_id(/:note)" => "registrations#tab"

  match "/email_template/create" => "emails#template_create"

  match "/email_templates/partial" => "email_templates#partial"

  match 'enquiries_action_partial/:partial_name/:enquiry_id/:list' => "enquiries#action_partial"

  match 'registrations_action_partial/:partial_name/:registration_id/:list(/:sub_type)' => "registrations#action_partial"

  match 'partners_action_partial/:partial_name/:partner_id/:list' => "partners#action_partial"

  match 'people_action_partial/:partial_name/:person_id/:list' => "people#action_partial"

  match 'partners_action_partial/:partial_name/:partner_id/:list(/:sub_type)' => "partners#action_partial"

  match "/emails/new" => "emails#new"

  match "/task_statuss" => "task_statuses#index"

 #match "/user_configuration" => "user_configs#edit"

  resources :user_configs

  resources :users do
    member do
      get :link
    end
  end

  resources :enquiry_statuses

  resources :email_templates

  resources :application_statuses



  match "/registrations.json/:status" => "registrations#index"

  resources :reg_courses


  resources :course_levels

   resources :student_sources

   resources :sub_agents

   resources :english_levels
   resources :exam_types
   resources :qualification_names
   resources :qualifications

  resources :course_subjects

  resources :people do
      collection { post :search, to: 'people#index' }
      member do
        get :clone
      end
  end
  resources :partners do
    collection { post :search, to: 'partners#index' }
    member do
        get :clone
    end
  end

  resources :enquiries do
      collection { post :search, to: 'enquiries#index' }
      member do
        get :clone
      end
  end
  resources :programmes do
      collection { post :search, to: 'programmes#index' }
      member do
        get :more
      end
  end

  resources :enquiry_sources

  match '/get_cities/:co_id(/:type)' => 'json#cities'

  match '/get_partner_types/:id' => 'json#partner_types'

  match '/get_student_sources/:contact_type_id' => 'json#student_sources'

  match '/get_partners/:country_id(/:city_id(/:ins_type_id))' => 'json#partners'

  get '/home/:type' => 'home#index'

  devise_scope :user do
    authenticated :user do
      root to: 'enquiries#index', as: :root
    end
  end


  devise_scope :registration do
    authenticated :registration do
      root to: 'students#index', as: :root
    end
  end

  devise_scope :partner do
    authenticated :partner do
      root to: 'company#index', as: :root
    end
  end

  root to: 'home#index'

  match '/not_found' => 'enquiries#error'

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'enquiries#error'
  end

end
