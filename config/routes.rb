PointB::Application.routes.draw do

  resources :comments

  # devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  devise_scope :user do
    get "/" => "devise/sessions#new"
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users do
    resources :destinations
  end
  
  scope :api do
    post 'destinations/:destination_id/posts' => 'destinations#post', :as => :destination_post_api
  end


  

end
