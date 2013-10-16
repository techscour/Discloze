SimpleAuth::Application.routes.draw do
  

  #get "edit/update"
  resources :lists, only: [:index, :create, :update, :destroy]
  resources :invitations, only: [:index, :destroy]
  resources :offers, only: [:index, :destroy]
  resources :updates, only: [:index, :destroy]
  resources :site_of_publics, only: [:index, :destroy]
  resources :app_of_publics, only: [:index, :destroy]
  resources :notices, only: [:index, :destroy]
  resources :edits, only: [:edit]
  resources :partner_apps, only: [:create]
  resources :partner_sites, only: [:create]
  resources :listables, only: [:index]
  resources :partner_apps, only: [:index]
  resources :partner_sites, only: [:index]

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

  get "/mobiles/list/:list_id", :to => "mobiles#list"
  namespace :mobiles do
    get "landing" 
    post "login"
    get "logout"
    get "lists"
  end
  
  namespace :apis do
    get "app_publics/:partner_app_id", :to =>"api#app_publics"
    get "site_publics/:partner_site_id", :to =>"api#site_publics"
    post "invite/:public_id", :to =>"api#invite"
    post "offer/:public_id", :to =>"api#offer"
    post "update/:public_id", :to =>"api#update"
    get "lists/:listable_id" , :to =>"api#lists"
    get "list/:list_id", :to =>"api#list"
    get "publics/:public_id/list/:list_id", :to =>"api#publics_list"
    get "publics/:public_id", :to =>"api#publics"
    get "publics_lists/:public_id/", :to =>"api#publics_lists"
    get "authorize", :to=>"api#authorize"
    get "adieu", :to=>"api#adieu"
  end

  root "session#landing"
end
