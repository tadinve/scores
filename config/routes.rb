Score::Application.routes.draw do
  
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => { :registrations => 'registrations' } do
    get '/users/sign_out' => 'devise/sessions#destroy' # added this becaause of sign_out bug.
  end
  
  resources :users
  controller :users do 
    match '/export_users', :action => 'export_to_excel', :as => 'export_users'
  end

  resources :authentications

  controller :home do
    match '/about', :action => 'about', :as => 'about'
    match '/home', :action => 'index', :as => 'home'
    match '/score', :action => 'score', :as => 'score'
    match '/get_score', :action => 'get_score', :as => 'get_score'
  end
  
  controller :devise_checker do
    match '/check_devise', :action => 'check_devise', :as => 'check_devise'
  end

  authenticated :user do
    root :to => 'home#score'
  end
  unauthenticated :user do
    root :to => 'devise_checker#check_devise'
  end

  
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
  # root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
