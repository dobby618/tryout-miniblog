# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, only: [:index, :new, :create, :destroy] do
    resource :like, only: [:show, :create, :destroy]
  end
  resources :profile, only: [:show]
  resource  :follow, only: [:create, :destroy]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
