Rails.application.routes.draw do

  root 'tweets#index'

  devise_for :users
  resources :users do
    member do
      get :following, :followers
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tweets, only: [:index, :new, :create]
  resources :profile, only: [:show]

  put 'tweets/like/:id' => 'tweets#like'
  delete 'tweets/dislike/:id' => 'tweets#dislike'
  get 'tweets/search' => 'tweets#search'
end
