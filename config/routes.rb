Rails.application.routes.draw do
  resources :orders


  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  
  resources :users
  resources :products do
    resources :orders
  end
  resources :profiles
  resources :charges

  # as :user do
  #   get '/profile' => 'users/registrations#edit', as: 'edit_user_registration'
  #   patch '/profile' => 'users/registrations#update'
  # end

  get "home/index"
  # get 'market', to: => 'products#index', as: => 'market'

  get '/profile', to:  'profile#index', as: 'user_profile'
  get '/dashboard', to:  'dashboard#index', as: 'dashboard'

  root "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
