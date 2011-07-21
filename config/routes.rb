Picturely::Application.routes.draw do
  
  resources :search_results

  resources :tweets

  resources :tweeters

  resources :albums
  get 'albums/:id/add_tweet' => 'albums#add_tweet', :as => :album_add_tweet
  get 'albums/:id/set_active'=> 'albums#set_active',:as => :album_set_active
  get 'albums/:id/tweets'    => 'albums#tweets',    :as => :album_tweets

  get "sessions/new"

  get "pages/home"

  get "pages/contact"

  get "pages/about"
  
  get "albums/index"
  
  match '/contact', :to => 'pages#content'
  match '/about', :to => 'pages#about'
  match '/signup', :to => 'users#new'
  match '/signin', :to=> 'sessions#new'
  match '/signout', :to=> 'sessions#destroy'
  match '/albums', :to=> 'album#index'

  resources :uploads
  resources :sessions, :only => [:new, :create, :destroy]

  get "realurl/resolve"
  
  root :to => 'home#index'

  resources :users

  # /:ID now invokes /albums/:ID - this should be the last route in
  # the routes file so that it doesn't inadvertently override other
  # explicit routes
  get ':id' => 'albums#show', :as => :album_default_show

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
