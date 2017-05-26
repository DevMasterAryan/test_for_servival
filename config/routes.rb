Rails.application.routes.draw do
  root 'users#signup'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/signup', to: "users#signup"
  post '/signup', to: "users#create"
  get '/login', to: "users#login"
  post '/login', to: "users#authorise_user"
  post '/home', to: "users#home"
  get '/home', to: "users#home"
end
