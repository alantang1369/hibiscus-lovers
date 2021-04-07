Rails.application.routes.draw do
  root 'static#home'
  resources :sales
  resources :cultivars
  resources :users

  get '/signin' => 'session#new'
  post '/session' => 'session#create'
  delete '/session' => 'session#destroy'

  post '/orders' => 'orders#create'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
