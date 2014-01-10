PointB::Application.routes.draw do
  resources :trips

  resources :destinations, only: :show

  devise_for :users

  resources :users

  root 'users#index'

end
