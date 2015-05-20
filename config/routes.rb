Rails.application.routes.draw do
  root to: redirect("http://www.taximatico.mx")

  devise_for :users, skip: [ :sessions, :registrations, :passwords ]

  scope module: :api, defaults: { format: :json } do
    namespace :users do
      resources :registrations, only: :create
      resources :verification_codes, only: [] do
        collection { post :check }
      end

      resources :drivers, only: :index

      resources :driver_requests, only: [ :create, :show ] do
        member do
          get :progress
        end
      end
    end
  end
end
