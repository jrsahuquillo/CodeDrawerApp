Rails.application.routes.draw do
  devise_for :users
  root to: "drawers#index"

  resources :drawers do
    resources :codetools
  end

  get '/search', to: 'codetools#search'
end
