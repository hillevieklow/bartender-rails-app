Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/login' => 'application#welcome'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get "/auth/facebook/callback" => "sessions#create"


  resources :recipes do
    resources :reviews # GET recipe/:id/reviews
    resources :recipe_ingredients
  end

  resources :users do
    resources :recipes
  end


  resources :ingredients, only: [:show]

  root 'application#welcome', as: :welcome

  post '/recipes/:id/upvote' => 'recipes#upvote'
  post '/recipes/:id/downvote' => 'recipes#downvote'

  get '/recipes/:id/next' => 'recipes#next_recipe'
  get '/recipes/:id/previous' =>'recipes#previous_recipe'
end
