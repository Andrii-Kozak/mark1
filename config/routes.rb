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
    resources :members, module: :groups, only: %i[index show create destroy] do
      delete 'remove_member', to: 'members#remove_member', as: :remove_member
    end
  end
end
