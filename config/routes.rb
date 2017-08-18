Rails.application.routes.draw do

  root 'application#hello'

  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/auth/facebook/callback', to: 'sessions#create'
  get '/json-test', to: 'projects#json-test'

  resources :projects do
    resources :notes, only: [:create]
    resources :assignments, only: [:create]
    delete '/assignments', to: 'assignments#destroy'
  end

  resources :tools, only: [:new, :create, :index, :destroy, :show]

  get '/users/busiest', to: 'users#busiest', as: 'busiest_workers'
  delete '/notes/:id', to: 'notes#destroy', as: 'delete_note'

  resources :users do
    resources :projects, only: [:index, :new]
    resources :assignments, only: [:create]
    delete '/assignments', to: 'assignments#destroy'
  end
end
