Rails.application.routes.draw do
  root to: redirect("http://www.taximatico.mx")

  scope module: :api, defaults: { format: :json } do
    namespace :users do
      resources :registrations, only: :create
    end
  end
end
