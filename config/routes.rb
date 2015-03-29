Rails.application.routes.draw do
  
  root 'dashboard#show', as: 'home'
  get 'ui(/:action)', controller: 'ui'

  
  
  resources :users, only: [:new, :create]
end
