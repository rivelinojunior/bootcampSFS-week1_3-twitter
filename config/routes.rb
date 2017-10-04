Rails.application.routes.draw do
  
  get 'tweets/new'

  get 'tweets/create'

  devise_scope :user do
    unauthenticated do
      root to: 'devise/sessions#new'
    end
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
