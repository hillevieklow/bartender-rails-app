Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/login' => 'application#welcome'
  post '/login' => 'sessions#create'
  resources :users
  root 'application#welcome', as: :welcome

end
