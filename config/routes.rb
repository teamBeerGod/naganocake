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
    resources :orders, only: [:index, :show, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :products, only: [:index, :new, :create, :show, :edit, :update]
    root :to =>"homes#top"
  end
  scope module: :public do
    resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]
    post 'orders/confirm' => 'orders#confirm', as: 'confirm' # 一時的に画面作成のため一時的にpost=>getに変更
    get 'orders/thanks' => 'orders#thanks', as: 'thanks'
    resources :orders, only: [:create, :index, :show, :new]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all'
    resources :cart_items, only: [:index, :destroy, :update, :create]
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    resources :customers, only: [:edit, :update, ]
    resources :sessions, only: [:new, :create, :destroy]
    resources :registrations, only: [:new, :create]
    resources :products, only: [:index, :show]
    root :to =>"homes#top"
   get "about" =>"homes#about", as: 'about'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
