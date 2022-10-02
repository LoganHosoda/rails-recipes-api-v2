Rails.application.routes.draw do
  resources :recipes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/recipes/details/:id', to: 'recipes#show'
  put '/recipes', to: 'recipes#update'
end
