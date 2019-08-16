Rails.application.routes.draw do
  root to: "drawers#index"

  resources :drawers
end
