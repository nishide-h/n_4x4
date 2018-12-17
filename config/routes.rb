# frozen_string_literal: true

Rails.application.routes.draw do
  root "sheets#index"
  resources :sheets do
    resources :tasks do
      member do
        patch "toggle_select1"
      end
    end
  end
end
