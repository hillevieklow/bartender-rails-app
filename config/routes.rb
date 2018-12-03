Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/login' => 'application#welcome'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get "/auth/:provider/callback" => "sessions#create"

  resources :recipes
  resources :users
  resources :recipe_ingedients do
    resources :ingredients, only: [:show]
  end
  resources :ingredients

  root 'application#welcome', as: :welcome

  post '/recipes/:id/upvote' => 'recipes#upvote'
  post '/recipes/:id/downvote' => 'recipes#downvote'
end
