Rails.application.routes.draw do

  resources :exercises, only: [:index, :show] do
    resources :solutions, only: [:show, :new, :create]
  end

resources :users, only: [:show]

  get 'auth/:provider/callback', to: 'sessions#create'

  root to: 'home#index'

end
