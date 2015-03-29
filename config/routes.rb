Rails.application.routes.draw do
  
  root 'dashboard#show', as: 'home'
  resources :users, only: [:new, :create]

  get 'ui(/:action)', controller: 'ui'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
end
