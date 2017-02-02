Rails.application.routes.draw do

  resources :exercises, only: [:index, :show]

  get 'auth/:provider/callback', to: 'sessions#create'

  root to: 'home#index'

end
