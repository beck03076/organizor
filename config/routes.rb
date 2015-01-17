require 'sidekiq/web'
Organizor::Application.routes.draw do

  resources :courses


  match '/document/edit/:id' => "documents#edit", via: :post

  match '/approve_requests/:registration_id' => 'approve_requests#update', via: :put

  match '/approval' => 'approve_requests#approve_or_reject', via: [:get, :post], as: :approval

  match '/approve_requests/:id' => 'approve_requests#delete', via: :delete

  mount Sidekiq::Web => '/sidekiq'

  devise_for :institutions, :controllers => {registrations: "institutions", confirmations: "institution_confirmations" }
  as :institution do
      match '/institution/confirmation' => 'institution_confirmations#update', :via => :put, :as => :update_institution_confirmation
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


  resources :typeaheads

  resources :required_docs
  resources :required_doc_types

  match '/typeaheads/:models/:col/:q' => 'typeaheads#results', format: false, constraints: { q: /[^\/]+/ }, via: [:get, :post]
  match '/analytics' => "analytics#index", via: [:get, :post], as: "analytics"
  match "/analytics/:core/:core_method/:core_params" => "analytics#show", via: :get

  post '/compare_users_modal' => 'user_metrics#compare_users_modal', via: [:get, :post]
  post '/compare_users' => 'user_metrics#compare_users', via: [:get, :post]

  post '/save_report' => 'reports#save_report'

  resources :saved_reports

  match "/reports/users/:module/:uids(/:tab)" => "user_metrics#index",via: :get

  post '/partial_pie' => "reports#partial_pie"
  post '/partial_bar' => "reports#partial_bar"

  match '/reports/core_modules/:module' => "reports#show", via: :get
  match '/reports/charts/:module' => "reports#charts", via: :get
  match '/reports/users/:module' => "reports#show", via: :get

  match '/reports' => "reports#index", as: "reports", via: :get

  post '/filter_reports' => "reports#show",via: :get, as: "filter_reports"

  match '/500' => 'handle#e_500', via: :get
  match '/404' => 'handle#e_500', via: :get
  match '/422' => 'handle#e_500', via: :get

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
  match "/all_notifications" => "application#all_notifications", via: [:get, :post]

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

  match '/institution_programmes/:institution_id.json' => "programmes#index", via: :get

  get 'create_fee/:programme_id' => "fees#create_fee"

  get 'emails/:id' => "emails#show"

  post '/emails/filter' => "emails#filter"

  get '/search/:model/:col/token.json' => "application#token_search"

  get '/get_column_names/:model/:filter' => "application#get_column_names"

  post '/filter_todos' => 'todos#index'

  match '/filter_users/:model(/:f_id)' => "users#index", via: :get

  match '/edit_resource/:r_name/:r_id' => "resources#edit", via: [:get, :post]

  match '/show_resource/:r_name/:r_id' => "resources#show", via: :get

  match '/user_configs/manage/:partial' => 'user_configs#manage', via: [:get, :post]

  match '/configuration' => 'resources#index', via: :get


  # this url will be hit once the google authentication is succesful
  match '/auth/:provider/callback' => 'application#determine_redirect', via: [:get, :post]

  match '/todos/google_create' => "todos#google_create", via: [:get, :post]

  match '/todos/start_sync' => "todos#start_sync", via: [:get, :post]

  match '/todos/google_sync' => "todos#google_sync", via: [:get, :post]

  resources :allow_ips

  get "white_list/index", as: "banned"

# this url will be hit once the google authentication is succesful
#  match "/contacts/:importer/callback" => "import#contacts"
# this url will be hit once the google authentication is succesful
 # get '/auth/:provider/callback' => 'import#contacts'

  get '/import_contacts/:from' => "import#start"
  resources :commission_statuses

  resources :commissions

  match '/validate_recruit/:ins_id/:form_country_id(/:model/:item_id)' => 'application#validate_recruit', via: [:get, :post]

  match '/srch_countries.json' => 'json#srch_countries',via: :get

  match '/srch_regions.json' => 'json#srch_regions', via: :get

  match '/institution_type/:type_id' => 'json#institution_type', via: :get

  match '/get_users/:branch_id' => 'json#get_users', via: :get

  match "/people/tab/:status/:partial(/:person_id)" => "people#tab", via: [:get, :post]

  resources :person_types

  resources :contract_doc_categories

  resources :institution_groups

  match "/institutions/tab/:status/:partial(/:institution_id)" => "institutions#tab", via: [:get, :post]

  resources :institution_types

  resources :contracts

  get "resources/index"

  get "handle/error"

  get "handle/cancan"

  resources :documents do
      collection do
        delete :delete
      end
  end

  match '/cal_click/:start(/:end)' => 'follow_ups#cal_click', via: [:get, :post]

  match "/show_browser/:id/:disposition" => "documents#show", via: :get

  match "/documents/delete_or_download" => "documents#delete_or_download", via: [:get, :post]

  devise_for :users, :controllers => { :invitations => 'users/invitations' }

  resources :smtps

  resources :roles

  resources :doc_categories

  resources :images

  resources :todo_statuses

  resources :contact_types

  resources :todo_topics

  resources :todos

  resources :notes

  resources :event_types

  resources :follow_ups

  resources :emails

  match "/all_notifications" => "application#all_notifications", via: [:get, :post]

  match "/email_sent_by/:sent_by" => "emails#index", via: :get

  match "/calendar_user/:user_id" => "follow_ups#index", via: :get

  match "/todo_assigned_to/:ass_to" => "todos#index", via: :get

  match "/todo_assigned_by/:ass_by" => "todos#index", via: :get

  match "/email_hover/:id" => "emails#show_hover", via: :get

  match "/follow_up_hover/:id" => "follow_ups#show_hover", via: :get

  match "/todo_hover/:id" => "todos#show_hover", via: :get

  match '/permissions/role/:role_id' => "roles#show_permissions", via: :get

  match '/bulk_email/:model/:model_ids' => "emails#bulk_email", via: [:get, :post]

  match '/group_assign/:model/:model_ids/branch/:branch_id/user/:user_id' => "application#group_assign", via: [:get, :post]

  match '/group_delete/:model/:model_ids' => "application#group_delete", via: [:get, :post, :delete]

  match "/enquiries/tab/:status/:partial(/:enquiry_id)" => "enquiries#tab", via: [:get, :post]

  match "/registrations/tab/:status/:partial(/:registration_id)" => "registrations#tab", via: [:get, :post]

  match "/register/tab/:status/:partial/:enquiry_id(/:note)" => "registrations#tab", via: [:get, :post]

  match "/email_template/create" => "emails#template_create", via: [:get, :post]

  match "/email_templates/partial" => "email_templates#partial", via: [:get, :post]

  match 'enquiries_action_partial/:partial_name/:enquiry_id/:list' => "enquiries#action_partial", via: [:get, :post]

  match 'registrations_action_partial/:partial_name/:registration_id/:list(/:sub_type)' => "registrations#action_partial", via: [:get, :post]

  match 'institutions_action_partial/:partial_name/:institution_id/:list' => "institutions#action_partial", via: [:get, :post]

  match 'people_action_partial/:partial_name/:person_id/:list' => "people#action_partial", via: [:get, :post]

  match "/emails/new" => "emails#new", via: :post

  match "/todo_statuss" => "todo_statuses#index", via: :get

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



  match "/registrations.json/:status" => "registrations#index", via: :get

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
  resources :institutions do
    collection { post :search, to: 'institutions#index' }
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

  match '/get_cities/:co_id(/:type)' => 'json#cities', via: :get

  match '/get_student_sources/:contact_type_id' => 'json#student_sources', via: :get

  match '/get_institutions/:country_id(/:city_id(/:ins_type_id))' => 'json#institutions', via: :get

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

  devise_scope :institution do
    authenticated :institution do
      root to: 'partners#index', as: :root
    end
  end

  root to: 'home#index'

  match '/not_found' => 'enquiries#error', via: :get

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'enquiries#error'
  end

end
