Rails.application.routes.draw do

 devise_for :admin,skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
 }

  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :products, only: [:index, :new, :create, :show, :edit, :update]
    root :to =>"homes#top"
  end
  scope module: :public do
    resources :shipping_addresses, only: [:edit, :create, :update, :destroy]
    resources :orders, only: [:create, :index, :show, :new]
    get 'orders/confirm' => 'orders#confirm', as: 'confirm'
    get 'orders/thanks' => 'orders#thanks', as: 'thanks'
    resources :cart_items, only: [:index, :destroy, :update, :create]
    get 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
    resources :customers, only: [:edit, :update]
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdrawal' => 'customers#withdrowal', as: 'withdrowal'
    resources :sessions, only: [:new, :create, :destroy]
    resources :registrations, only: [:new, :create]
    resources :products, only: [:index, :show]
    root :to =>"homes#top"
   get "about" =>"homes#about", as: 'about'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
