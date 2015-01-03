Echef::Application.routes.draw do

  match "/menu" => "menu#index"

  match "/menu/:qr" => "menu#table"

  match "/order/add/:dish_id" => "menu#add"

  match "/order/remove/:dish_id" => "order#remove"

  match "/order/send" => "order#send_order"
  match "/order/waiter" => "order#call_waiter"
  match "/order/check" => "order#request_check"

  match "/order" => "order#index"

  match "/mark_as_payed" => "orders#mark_as_payed"
  match "/change_order_time" => "orders#change_order_time"

  get "users/profile"

  match "/contact" => "pages#contact"
  match "/gallery" => "pages#gallery"

  get "pages/home"
  
  get "/qr/:qr_code" => "qr#index"
  
  post "/tables/change_qr/:table_id" => "tables#change_qr"

	root :to => "pages#home"

  resources :complaints

  resources :order_dishes

  resources :orders

  resources :bookings

  match "/notifications/count" => "notifications#count"
  match "/notifications/refresh" => "notifications#refresh"

  resources :notifications

  match "/mark_noti_as_done" => "notifications#mark_as_done"

  resources :tables

  devise_for :users, :skip => [:registrations]
    as :user do
      #get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
      # put 'users' => 'devise/registrations#update', :as => 'user_registration'
      get 'users' => 'users/admin#show', :as => 'users'
      delete 'users/:id' => 'users/admin#destroy'
      get 'user/new' => 'users/admin#new', :as => 'new_user'
      post 'users' => 'users/admin#create'
    end

  match "/users/:id/edit" => "users#edit", :via => [:get]
  match "/users/:id" => "users#update", :via => [:put]
  match "/users/:id" => "users#show", :as => :user, :via => [:get]

  resources :dishes

  resources :dish_types

  match "/mark_dishes_as_preparing" => "dishes#mark_dishes_as_preparing"
  match "/mark_dishes_as_ready" => "dishes#mark_dishes_as_ready"
  match "/mark_dishes_as_delivered" => "dishes#mark_dishes_as_delivered"
  match "/mark_as_closed" => "orders#mark_as_closed"

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
