ParseRailsBoilerplate::Application.routes.draw do
  get "log_in" => "sessions#new", :as => "log_in"  
  get "log_out" => "sessions#destroy", :as => "log_out"  
  
  get "sign_up" => "users#new", :as => "sign_up"  
  root :to => "welcome#index"  

  get "profile" => "users#profile"


  resources :users  
  resources :sessions 
end
