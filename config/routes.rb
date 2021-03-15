Rails.application.routes.draw do
  mount_graphql_devise_for 'User', at: 'graphql_auth'
  # devise_for :users
  post "/api/graphql", to: "api/graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
