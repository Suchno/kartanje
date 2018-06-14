Rails.application.routes.draw do
  devise_for :companies
  devise_for :users
  resources :departures
  resources :histories
  root "departures#index"
  post 'buy', to: 'departures#buy', as: 'buy'
end
