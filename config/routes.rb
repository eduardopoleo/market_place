Rails.application.routes.draw do
  
  root 'welcome#index'
  get 'ui(/:action)', controller: 'ui'

end
