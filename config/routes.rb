Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/login' => 'application#welcome'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get "/auth/facebook/callback" => "sessions#create"

  resources :recipes
  resources :users, only: [:new, :show]
  resources :recipe_ingedients do
    resources :ingredients, only: [:show]
  end
  resources :ingredients, only: [:show]

  root 'application#welcome', as: :welcome

  post '/recipes/:id/upvote' => 'recipes#upvote'
  post '/recipes/:id/downvote' => 'recipes#downvote'
end
