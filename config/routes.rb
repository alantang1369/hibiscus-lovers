Rails.application.routes.draw do
  root 'static#home'
  resources :sales do 
    resources :orders, only: [:create, :update, :show, :destroy ]
  end
  resources :cultivars do 
    resources :sales 
  end
  resources :users do 
    resources :sales 
  end

  #resources :orders, only: [:show]

  get '/signin' => 'session#new'
  post '/session' => 'session#create'
  delete '/session' => 'session#destroy'

  post '/sales/:sale_id/orders/place' => 'orders#place', as: "place_order"
  get '/sales/:sale_id/orders/:id/confirm' => 'orders#confirm', as: "confirm_order"
  resources :users do
    resources :orders, only: [:index, :show]
  end

  post '/auth/github/callback', to: 'session#create_with_github'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
