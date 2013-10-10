Organizor::Application.routes.draw do

  resources :documents do
      collection do
        delete :delete
      end
  end
  resources :doc_categories


  resources :todo_statuses


  resources :todo_topics


  resources :todos
  
  resources :notes


  resources :event_types

  resources :follow_ups


  devise_for :users
  
  match '/group_assign/:model/:model_ids/user/:user_id' => "application#group_assign"
  
  match "/enquiries/tab/:status/:partial(/:enquiry_id)" => "enquiries#tab"
  
 match "/registrations/tab/:status/:partial(/:registration_id)" => "registrations#tab"  
  
  match "/email_template/create" => "emails#template_create"
  
  match "/email_templates/:etemp_id/:model/:e_id/:list" => "email_templates#partial"
  
  match 'enquiries_action_partial/:partial_name/:enquiry_id/:list' => "enquiries#action_partial"
  match 'registrations_action_partial/:partial_name/:registration_id/:list' => "registrations#action_partial"
  
  match "/emails/new" => "emails#new"
  
  match "/todo_statuss" => "todo_statuses#index"
  
#  match "/user_configuration" => "user_configs#edit"
  
  resources :user_configs

  resources :users


  resources :enquiry_statuses
  resources :email_templates


  resources :application_statuses


  resources :registrations
  match "/registrations.json/:status" => "registrations#index"

  resources :reg_courses


  get "emails/save_send"

  resources :course_levels
  
   resources :student_sources
   
   resources :sub_agents
   
   resources :english_levels
   resources :exam_types
   resources :qualifications
  
  resources :course_subjects


  resources :institutions


  resources :enquiries


  resources :programmes


  resources :programme_types


  resources :enquiry_sources
  
  match '/emails' => 'emails#save_send'
  
  match '/get_cities/:co_id' => 'json#cities'
  
  match '/get_institutions/:geo/:c_id(/:p_type_id)' => 'json#institutions'  


 
  
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
  
  root :to => "enquiries#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
