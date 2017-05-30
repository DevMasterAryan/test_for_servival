Rails.application.routes.draw do
  get 'sessions/new'

  root 'users#signup'
  resources :users
  resources :friendships
  resources :sessions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/signup', to: "users#signup"
  post '/signup', to: "users#create"
  get '/login', to: "sessions#new"
  post 'sessions/new', to: "sessions#create"
  delete 'logout', to: "sessions#destroy"
  post '/home', to: "users#home"
  get '/home', to: "users#home"
end
