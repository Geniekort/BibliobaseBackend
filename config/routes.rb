Rails.application.routes.draw do
  post "/api//graphql", to: "api/graphql#execute"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
