Rails.application.routes.draw do
  get 'notes/create'

  root 'application#hello'
  resources :projects do
    resources :notes, only: [:create]
    resources :assignments, only: [:create]
    delete '/assignments', to: 'assignments#destroy'
  end
  delete '/notes', to: 'notes#destroy', as: 'delete_note'
  resources :users do
    resources :projects
    resources :assignments, only: [:create]
    delete '/assignments', to: 'assignments#destroy'
  end
  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

end
