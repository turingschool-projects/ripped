Rails.application.routes.draw do

  resources :exercises do
    resources :solutions, only: [:show, :new, :create]
  end

  resources :solutions, except: [:index] do
    resources :feedbacks, except: [:show]
  end


  get '/dashboard', to: 'dashboard#show'

  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'auth/:provider/callback', to: 'sessions#create'

  root to: 'home#index'

end
