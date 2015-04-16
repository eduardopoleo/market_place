Rails.application.routes.draw do
  root 'welcome#landing_page'

  resources :products, only: [:index, :show]
  resources :order_items, only: [:create]
  resources :carts, only: [:show, :create]
  resources :payments, only: [:new, :create]

  get '/payment_completed', to: 'payments#payment_completed', as: 'payment_completed'
  resources :users, only: [:new, :create] do
    member do
      get '/dashboard', to: 'users#dashboard'
    end
  end

  get 'ui(/:action)', controller: 'ui'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  mount StripeEvent::Engine, at: '/stripe_events'
end
