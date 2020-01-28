Rails.application.routes.draw do
  resources :service_orders
  resources :repair_tasks
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get "/", to: "session#new", as: :root
  post "/session", to: "session#create", as: :login
  
  resources :service_orders
end
