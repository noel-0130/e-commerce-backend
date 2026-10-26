Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    resources :products, only: [:index, :show, :create, :update, :destroy]

    resources :carts, only: [:create, :show] do
      resources :cart_items, only: [:create, :update, :destroy]
    end

    post "carts/:cart_id/checkout", to: "checkouts#create"

    resources :orders, only: [:index, :show]

    namespace :v1 do
      post "auth/google", to: "auth#google"
      get "auth/me", to: "auth#me"
      delete "auth/logout", to: "auth#logout"
    end
  end
end