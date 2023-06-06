Rails.application.routes.draw do
  resources :views
  resources :ads
 
  resources :users, param: :_username
  post '/auth/login', to: 'authentication#login'
end
