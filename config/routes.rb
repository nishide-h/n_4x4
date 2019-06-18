# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  resources :sheets do
    member do
      patch "next_status"
      patch "prev_status"
    end

    resources :tasks do
      member do
        patch "toggle_select1"
        patch "toggle_select2"
        patch "toggle_select3"
      end
    end
  end
end
