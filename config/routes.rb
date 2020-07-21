# frozen_string_literal: true

Rails.application.routes.draw do
  root 'articles#index'
  resources :articles, only: [:index, :new, :create, :destroy] do
    resource :like, only: [:show, :create, :destroy]
    resources :comments, only: [:index, :create]
  end
  resources :profile, param: :name, only: [:show]
  resource  :follow, only: [:create, :destroy]

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
