Rails.application.routes.draw do

  root 'tweets#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :tweets, only: [:index, :new, :create]
  resources :profile, only: [:show]
  resources :relationships, only: [:create, :destroy]

  put 'tweets/like/:id' => 'tweets#like', as: 'like_path'
  delete 'tweets/dislike/:id' => 'tweets#dislike', as: 'dislike_path'
  get 'tweets/search' => 'tweets#search'
end
