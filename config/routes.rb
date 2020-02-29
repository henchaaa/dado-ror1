Rails.application.routes.draw do
  resources :service_orders
  resources :repair_tasks
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get "/", to: "session#new", as: :root
  post "/session", to: "session#create", as: :login 
  get "/repair_tasks/new", to: "repair_tasks#new", as: "repair"
  get "/search", to: "service_orders#search", as: "search_page"
  resources :service_orders
end
