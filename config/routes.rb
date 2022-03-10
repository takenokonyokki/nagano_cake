Rails.application.routes.draw do
  root to: 'public/homes#top'

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get 'homes/top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  namespace :public do
    get 'homes/about', as:'about'
    resources :customers, only: [:show, :edit, :update]
    get 'customers/:id/unsubscribe' => 'customers#unsubscribe', as:'unsubscribe'
    patch 'customers/:id/withdraw' => 'customers#withdraw', as:'withdraw'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :create, :destroy] do
      collection do
        delete '', to: 'cart_items#destroy_all', as:'destroy_all'
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post :confirm, as:'confirm'
        get :complete, as:'complete'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
