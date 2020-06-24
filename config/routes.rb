# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, only: [:index, :new, :create, :destroy]
end
