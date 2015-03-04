Rails.application.routes.draw do  
  devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks" }
  resources :users, only: [ :index ]
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch, :put], :as => :finish_signup
  match "/users/edit" => "users#update_role", via: [:patch, :put], as: :update_role
  resources :wikis do 
    resources :collaborators
  end
  get "about" => "welcome#about"
  get "contact" => "welcome#contact"
  authenticated :user do 
    root "wikis#index", as: :authenticated_user
  end
  resources :charges, only: [:new, :create]
  root to: 'welcome#index'
end
