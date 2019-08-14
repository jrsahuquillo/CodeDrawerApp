Rails.application.routes.draw do
  root to: "cases#index"

  resources :cases
end
