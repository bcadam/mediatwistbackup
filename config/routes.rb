ParseRailsBoilerplate::Application.routes.draw do
  get "log_in" => "sessions#new", :as => "log_in"  
  get "log_out" => "sessions#destroy", :as => "log_out"  
  
  get "sign_up" => "users#new", :as => "sign_up"  
  root :to => "welcome#index"  

  get "profile" => "users#profile", :as => "profile"
  get "index" => "welcome#index"  


  get "add_site" => "sites#new", :as => "add_site" 


  get "getpage" => "sites#getpage"

  get "mediatwist" => "twister#mediatwist"
  
  #get "/site/:id" => "sites#show"

  #post "/asset/create" => "assets#create"

  get "admin" => "admin#index"


  resources :bassets
  resources :users  
  resources :sessions 
  resources :sites
  resources :targets

  get "getpage:id" => "sites#getpage"
  
end
