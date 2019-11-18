Rails.application.routes.draw do
  devise_for :users
  root to: "drawers#index"

  resources :drawers do
    resources :codetools do
      collection do
        patch :sort
      end
    end
  end

  get '/search', to: 'codetools#search'
end
