Rails.application.routes.draw do
  resources :campers, only: [:index]
  resources :campsites, only: [:index]
  resources :supplies, only: [:index]
end
