Rails.application.routes.draw do
  devise_for :users
  resources :games, except: [:destroy, :edit, :update]
  get '/leaderboard', to: 'leaderboard#index'
  get '/history', to: 'games#index'
  root to: "games#index"
end
