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
  
  namespace :admin do
    get 'top' => 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
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
    
    get 'items/myitems' => 'items#myitem', as: 'myitems'
    
    resources :items, only: [:index, :show, :new, :edit, :create, :update]
  end
  
end
