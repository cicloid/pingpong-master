Rails.application.routes.draw do
  devise_for :users
  resources :games, except: [:destroy, :edit, :update]
  get '/history', to: 'home#history'
  get '/log',     to: 'home#log'
  root to: "home#index"
end
