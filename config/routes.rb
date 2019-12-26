Rails.application.routes.draw do
  get "/", to: "session#new"
end
