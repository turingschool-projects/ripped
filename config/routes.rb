Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'

  get '/', to: 'home#index'

end
