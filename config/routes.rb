Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root 'static_pages#index'
  get '/about', to: 'static_pages#about'
  resources :users do
    member do
      get 'groups', to: 'users#groups', as: :groups
    end
  end
  resources :groups do
    member do
      get 'members', to: 'groups#members', as: :users
      post 'follow', to: 'groups#follow', as: :follow
      delete 'unfollow', to: 'groups#unfollow', as: :unfollow
    end
  end
end
