Rails.application.routes.draw do
  
  devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks" }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch, :put], :as => :finish_signup
  resources :wikis
  get "about" => "welcome#about"
  get "contact" => "welcome#contact"
  authenticated :user do 
    root "wikis#index", as: :authenticated_user
  end

  root to: 'welcome#index'
end
