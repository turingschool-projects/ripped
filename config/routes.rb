Rails.application.routes.draw do

  resources :exercises, only: [:index, :show] do
    resources :solutions, only: [:show, :new, :create]
  end

  resources :solutions do
    resources :feedbacks, except: [:show]
  end


  get '/dashboard', to: 'dashboard#show'

  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'auth/:provider/callback', to: 'sessions#create'

  root to: 'home#index'

end
