PointB::Application.routes.draw do

  devise_scope :user do
    get "/" => "devise/sessions#new"
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :users do
    resources :destinations
  end


  resources :stars, :except => :create
  post '/destinations/:destination_id/stars' => 'stars#create', :as => :star_post


  get "/destinations" => "destinations#index", :as => :destination_search

  get "/followers" => "users#followers", :as => :followers_list


  resources :friendships
  resources :comments
  resources :activities, only: :index

  scope :api do
    post 'destinations/:destination_id/posts' => 'destinations#post', :as => :destination_post_api
  end
end
