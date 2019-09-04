# frozen_string_literal: true
require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
  resources :teams do
    get :download_logo, on: :member
    get :eee_logos, on: :member
  end
  post 'bulk', to: 'teams#bulk'
  resources :players, only:  %i[index show create update]
  resources :managers, only: %i[index show create update]
end
