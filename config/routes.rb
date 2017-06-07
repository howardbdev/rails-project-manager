Rails.application.routes.draw do
  get 'notes/create'

  root 'application#hello'
  resources :assignments
  resources :projects do
    resources :notes
  end
  resources :users do
    resources :projects
  end
  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

end
