Rails.application.routes.draw do
  root 'application#hello'
  resources :assignments
  resources :projects
  resources :users
  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

end
