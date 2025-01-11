Rails.application.routes.draw do
  devise_for :users

  # get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      post '/users/signup', to: 'auth#signup'
      post '/users/login', to: 'auth#login'

      resources :hostels, only: [:index, :create, :update, :destroy] do
        resources :rooms, only: [:index, :create]
      end

      resources :rooms, only: [:update, :destroy] do
        collection do
          get :search
        end
        resources :bookings, only: [:create]
      end

      resources :bookings, only: [:index, :destroy] do
        member do
          put :approve
          put :reject
        end
      end
    end
  end
end
