Rails.application.routes.draw do
  devise_for :users
  root to: "drawers#index"

  resources :drawers
end
