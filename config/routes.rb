Rails.application.routes.draw do
  # resources :campers, only: [:index]

  get "/campers", to: "static_pages#index"
  get "/campgrounds", to: "static_pages#index"


  # resources :campsites, only: [:index]
  # resources :supplies, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :campers, only: [:index, :create]
    end
  end
end
