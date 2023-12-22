Rails.application.routes.draw do
  namespace :admin do
    get 'order_details/update'
  end
  namespace :admin do
    get 'index/show'
    get 'index/update'
  end
  namespace :public do
    get 'order/new'
    get 'order/index'
    get 'order/create'
    get 'order/show'
    get 'order/confirm'
    get 'order/thanks'
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  namespace :admin do
    get 'top' => 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update] do
      resources :order_details, only: [:update]
    end
  end
  
  scope module: :public do
    root to: 'homes#top'
    get 'homes/about'
    
    
    # customers/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    
    get 'customers/mypage' => 'customers#mypage', as: 'mypage'
    get 'customers/information/:id' => 'customers#show', as: 'show_information'
    get 'customers/mypage/edit' => 'customers#edit', as: 'edit_mypage'
    patch 'customers/mypage' => 'customers#update', as: 'update_mypage'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'confirm_unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/thanks' => 'orders#thanks', as: 'thanks'

    get 'items/myitems' => 'items#myitem', as: 'myitems'
    
    resources :items do
      resources :cart_items, only: [:create, :update, :destroy]
    end
    resources :cart_items, only: [:index]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :index, :create, :show]
  end
  
end
