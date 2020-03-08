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
  get '/search-friends', to: 'friendships#search_friends'
  get '/friends', to: 'friendships#index'
  post '/friends', to: 'friendships#create'
  delete '/friends', to: 'friendships#destroy'

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

end
