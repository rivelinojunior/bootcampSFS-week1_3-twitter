Rails.application.routes.draw do

  root 'tweets#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :tweets, only: [:index, :new, :create]
  resources :profile, only: [:show]

  put 'tweets/like/:id' => 'tweets#like'
  delete 'tweets/dislike/:id' => 'tweets#dislike'
  get 'tweets/search' => 'tweets#search'
end
