SimpleAuth::Application.routes.draw do
  

  #get "edit/update"
  resources :publics do
    resources :lists, only: [:index, :create, :update, :destroy]
    resources :invitations, only: [:index, :destroy]
    resources :offers, only: [:index, :destroy]
    resources :updates, only: [:index, :destroy]
    resources :site_of_publics, only: [:index, :destroy]
    resources :app_of_publics, only: [:index, :destroy]
    resources :notices, only: [:index, :destroy]
    resources :edits, only: [:edit]
    #resources :emails, only: [:create]
    resources :partner_apps, only: [:create]
    resources :partner_sites, only: [:create]
  end

  resources :listables, only: [:index]
  resources :partner_apps, only: [:index]
  resources :partner_sites, only: [:index]

  #resources :partners, only: [:index, :get, :create, :update, :destroy] do
    #resources :partner_apps, only: [:index, :get, :create, :update, :destroy]
    #resources :partner_sites, only: [:index,:get, :create, :update, :destroy]
  #end

  #resources :listables, only: [:index]
  namespace :session do
    get "landing"
    get "signin"
    get "signup"
    get "update"
    get "passup"
    get "preset"
    post "authorize"
    post "amend"
    post "add"
    post "alter"
    get "abandon"
    post "ask"
    post "abolish"
    get "about"
    get "download"
    post "mail"
  end

  get "/auth/:provider/callback", :to => "session#create"
  get "/auth/failure", :to => "session#failure"

  namespace :mobiles do
    get "landing" 
    post "login"
    get "logout"
    get "lists"
    get "list/:list_id", :to => MobilesController.action(:list) #"list"
  end

  namespace :apis do
    get "app_publics/:partner_app_id", :to=>"api#app_publics"
    get "site_publics/:partner_site_id", :to=>"api#site_publics"
    post "invite/:public_id", :to=>"api#invite"
    post "offer/:public_id", :to=>"api#offer"
    post "update/:public_id", :to=>"api#update"
    get "lists/:listable_id" , :to=>"api#lists"
    get "list/:list_id", :to=>"api#list"
    get "publics/:public_id/list/:list_id", :to=>"api#publics_list"
    get "publics/:public_id", :to=>"api#publics"
    get "publics_lists/:public_id/", :to=>"api#publics_lists"
    get "authorize/:key", :to=>"api#authorize"
    get "adieu", :to=>"api#adieu"
  end

  root "session#landing"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
