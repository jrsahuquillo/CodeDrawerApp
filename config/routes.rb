Rails.application.routes.draw do
  devise_for :users
  root to: "drawers#index"

  resources :drawers do
    collection do
      patch :sort_drawer
    end
    resources :codetools do
      collection do
        patch :sort_codetool
      end
    end
  end

  get '/search', to: 'codetools#search'
  get '/search-friends', to: 'friends#search_friends'
  get '/friends', to: 'friends#index'
  post '/friends', to: 'friends#create'
  delete '/friends', to: 'friends#destroy'


end
