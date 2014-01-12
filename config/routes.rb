PointB::Application.routes.draw do

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  scope :api do
    post 'destinations/:id/posts' => 'destinations#post', :as => :destination_post_api
  end

  resources :users do
    resources :destinations
  end

  devise_scope :user do
    get "/" => "devise/sessions#new"
  end

end
