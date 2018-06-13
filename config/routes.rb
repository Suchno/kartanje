Rails.application.routes.draw do
  devise_for :companies
  devise_for :users
  resources :departures
  root "departures#index"
end
