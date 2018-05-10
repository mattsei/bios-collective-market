Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  
  resources :users
  resources :products
  resources :profiles

  get "home/index"
  # get 'market', to: => 'products#index', as: => 'market'

  get '/profile', to:  'profile#index', as: 'user_profile'

  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
