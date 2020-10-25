Rails.application.routes.draw do
  post '/users/auth'
  resources :schedule_users
  resources :schedules
  resources :hospitals
  resources :doctors
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
