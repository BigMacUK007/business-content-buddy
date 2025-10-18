Rails.application.routes.draw do
  devise_for :users
  
  # Root path
  authenticated :user do
    root "dashboard#index", as: :authenticated_root
  end
  root "dashboard#index"

  # Dashboard
  get "dashboard", to: "dashboard#index"

  # Posts
  resources :posts do
    member do
      patch :ship
      patch :unship
    end
  end

  # Journal Entries
  resources :journal_entries, only: [:index, :new, :create, :destroy] do
    member do
      post :convert_to_post
    end
  end

  # Proof Items
  resources :proof_items, only: [:index, :new, :create, :destroy]

  # Weekly Reviews
  resources :weekly_reviews, only: [:index, :new, :create, :show]

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA files
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end

