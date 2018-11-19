# frozen_string_literal: true

Rails.application.routes.draw do
  root "sheets#index"
  resources :sheets do
    resources :tasks
  end
end
