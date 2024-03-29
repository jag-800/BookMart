Rails.application.routes.draw do
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

  # ゲストログイン用のパス
  devise_scope :customer do
    post '/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, except: [:destroy] do
      collection do
        get 'search'
      end
    end
    resources :orders, only: [:index, :show, :update]
    resources :notices, only: :index
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
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/thanks' => 'orders#thanks', as: 'thanks'
    get 'orders/buyer' => 'orders#buyer', as: 'buyer'
    get 'orders/details/:id' => 'orders#details', as: 'order_details'
    get 'items/tag' => 'items#tag'
    get 'favorites/tag' => 'favorites#tag'
    get 'favorites/index' => 'favorites#index' , as: "favorites"


    resources :items do
      resource :favorite, only: [:create, :destroy]
      resources :item_comments, only: [:create, :destroy]
      collection do
        get 'search'
      end
    end
    resources :orders, only: [:index, :create, :show, :update]
    resources :chats, only: [:show, :create, :destroy]
    resources :notices, only: :index
  end

end
