Rails.application.routes.draw do
  root 'application#hello'
  resources :sessions
  resources :assignments
  resources :projects
  resources :users

end
