Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show] do
        resources :solutions, only: [:show, :index] do
          resources :feedbacks, only: [:index, :show, :update]
        end
      end
      resources :exercises, only: [:index, :show] do
        resources :solutions, only: [:show, :index]
      end
      resources :solutions, only: [:none] do
        resources :feedbacks, only: [:show, :update]
      end
      
      get '/solutions', to: 'solutions#uncommented'
    end
  end

  resources :exercises do
    resources :solutions, only: [:index, :show, :new, :create]
  end

  resources :solutions, only: [:none] do
    resources :feedbacks, except: [:index, :show]
  end


  get '/dashboard', to: 'dashboard#show'

  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'auth/:provider/callback', to: 'sessions#create'

  root to: 'home#index'

end
