Rails.application.routes.draw do
  
  root 'welcome#landing_page'

  resources :users, only: [:new, :create] do
    member do
      get '/dashboard', to: 'users#dashboard'
    end
  end

  get 'ui(/:action)', controller: 'ui'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
end
