Rails.application.routes.draw do

  root 'posts#index'

  match '/posts/random', :to => 'posts#random', :via => :get, :format => :json
  resources :posts

end
