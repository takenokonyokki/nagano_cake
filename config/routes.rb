Rails.application.routes.draw do
  root to: 'public/homes#top'

  namespace :admin do
    get 'homes/top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end

  namespace :public do
    get 'homes/about', as:'about'
    resources :customers, only: [:show, :edit, :update]
    get 'customers/:id/unsubscribe' => 'customers#unsubscribe', as:'unsubscribe'
    patch 'customers/:id/withdraw' => 'customers#withdraw', as:'withdraw'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
