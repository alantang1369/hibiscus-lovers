Rails.application.routes.draw do
  root 'static#home'
  resources :sales do 
    resources :orders 
  end
  resources :cultivars do 
    resources :sales 
  end
  resources :users do 
    resources :sales 
  end

  get '/signin' => 'session#new'
  post '/session' => 'session#create'
  delete '/session' => 'session#destroy'

  post '/orders/:id/confirm' => 'orders#confirm', as: "confirm_order"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
