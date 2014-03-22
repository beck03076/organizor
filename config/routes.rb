Organizor::Application.routes.draw do

  resources :processing_fee_statuses

  resources :processing_fee_types

  resources :progression_statuses

  resources :commission_claim_statuses
  
  resources :exams
  
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
  
  match '/institution_programmes/:institution_id.json' => "programmes#index"
  
  get 'create_fee/:programme_id' => "fees#create_fee"
  
  get 'emails/:id' => "emails#show"
  
  post '/emails/filter' => "emails#filter"
  
  get '/search/:model/:col/token.json' => "application#token_search"
  
  get '/get_column_names/:model/:filter' => "application#get_column_names"
  
  post '/filter_todos' => 'todos#index'
  
  match '/filter_users/:model(/:f_id)' => "users#index"
  
  match '/edit_resource/:r_name/:r_id' => "resources#edit"
  
  match '/show_resource/:r_name/:r_id' => "resources#show"
  
  match '/user_configs/manage/:partial' => 'user_configs#manage'
  
  match '/configuration' => 'resources#index'


  # this url will be hit once the google authentication is succesful
  match '/auth/:provider/callback' => 'application#determine_redirect'
  
  match '/todos/google_create' => "todos#google_create"
  
  match '/todos/start_sync' => "todos#start_sync"
  
  match '/todos/google_sync' => "todos#google_sync"

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

  match '/institution_type/:type_id' => 'json#institution_type'

  match "/people/tab/:status/:partial(/:person_id)" => "people#tab"  
  
  resources :person_types

  resources :contract_doc_categories

  resources :institution_groups

  match "/institutions/tab/:status/:partial(/:institution_id)" => "institutions#tab"  

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
  
  match '/cal_click/:start(/:end)' => 'follow_ups#cal_click'
  
  match "/show_browser/:id/:disposition" => "documents#show"  

  match "/documents/delete_or_download" => "documents#delete_or_download"
  
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
  
  match "/all_notifications" => "application#all_notifications"
  
  match "/email_sent_by/:sent_by" => "emails#index"
  
  match "/calendar_user/:user_id" => "follow_ups#index"
  
  match "/todo_assigned_to/:ass_to" => "todos#index"
  
  match "/todo_assigned_by/:ass_by" => "todos#index"
  
  match "/email_hover/:id" => "emails#show_hover"
  
  match "/follow_up_hover/:id" => "follow_ups#show_hover"
  
  match "/todo_hover/:id" => "todos#show_hover"

  match "/notify/:receiver_id/:t_id" => "application#notify"
  
  match "/mark_all_check/:id" => "application#mark_all_check"
  
  match '/permissions/role/:role_id' => "roles#show_permissions"
  
  match '/bulk_email/:model/:model_ids' => "emails#bulk_email"
  
  match '/group_assign/:model/:model_ids/user/:user_id' => "application#group_assign"
  
  match '/group_delete/:model/:model_ids' => "application#group_delete"
  
  match "/enquiries/tab/:status/:partial(/:enquiry_id)" => "enquiries#tab"
  
  match "/registrations/tab/:status/:partial(/:registration_id)" => "registrations#tab"  
 
 match "/register/tab/:status/:partial/:enquiry_id(/:note)" => "registrations#tab" 
  
  match "/email_template/create" => "emails#template_create"
  
  match "/email_templates/partial" => "email_templates#partial"
  
  match 'enquiries_action_partial/:partial_name/:enquiry_id/:list' => "enquiries#action_partial"
  
  match 'registrations_action_partial/:partial_name/:registration_id/:list' => "registrations#action_partial"
  
  match 'institutions_action_partial/:partial_name/:institution_id/:list' => "institutions#action_partial"
  
  match "/emails/new" => "emails#new"
  
  match "/todo_statuss" => "todo_statuses#index"
  
 #match "/user_configuration" => "user_configs#edit"
  
  resources :user_configs

  resources :users

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
  resources :registrations do
      collection { post :search, to: 'registrations#index' }
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
  
  match '/get_institutions/:country_id(/:city_id(/:ins_type_id))' => 'json#institutions'  
 
  match '/not_found' => 'enquiries#error'

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'enquiries#error'
  end
  
  #match '/programme_filter/:type/:country(/:city)' => 'enquiries#programme_filter'
  


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  
  root :to => "users#index"
 # match '(*foo)' =>  'whitelist#index', constraints: BlacklistConstraint.new

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
