Rails.application.routes.draw do

  resources :exercises do
    resources :solutions
  end

  resources :solutions, only: [:none] do
    resources :feedbacks, except: [:index, :show]
  end


  get '/dashboard', to: 'dashboard#show'

  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'auth/:provider/callback', to: 'sessions#create'

  root to: 'home#index'

end
