Rails.application.routes.draw do
  root 'sheets#index'
  resources :sheets
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
