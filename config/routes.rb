Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }
  root to: 'drawers#index'

  get '/users/:id/public_codetools' => 'users#public_codetools', as: :user_public_codetools
  get '/users/:id/last_notifications' => 'users#last_notifications', as: :user_last_notifications


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
  get '/public_codetools', to: 'friendships#index'
  post '/friends', to: 'friendships#create'
  delete '/friends', to: 'friendships#destroy'

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
  match 'notifications', to: 'notifications#clear', via: :delete

  resources :favorite_codetools
  resources :pin_codetools
  match 'pin_codetools', to: 'pin_codetools#clear', via: :delete

end
