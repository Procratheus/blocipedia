Rails.application.routes.draw do
  
  devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks" }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch, :put], :as => :finish_signup
  root 'welcome#index'

end
