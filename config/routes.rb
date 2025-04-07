Rails.application.routes.draw do
  resources :products
  resources :categories
  resource :shipment, only: [ :create, :show, :edit, :update, :new ]
  resource :cart, only: [ :show ] do
    post "add/:product_id", to: "carts#add", as: "add"
    patch "update/:product_id", to: "carts#update", as: "update"
    delete "remove/:product_id", to: "carts#remove", as: "remove"
  end
  resource :checkout, only: [ :show, :create ] do
    get "success", to: "checkouts#success"
    get "error", to: "checkouts#error"
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    sessions: "users/sessions"
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "products#index"
end
