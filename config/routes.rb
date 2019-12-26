Rails.application.routes.draw do
  resources :service_orders
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get "/", to: "session#new", as: :root
  post "/session", to: "session#create", as: :login
end
