Rails.application.routes.draw do

  get 'order_management/index'  
  get 'order_management/admin_index'
  get 'order_management/edit/:id', to: 'order_management#edit', as: :order_management_edit
  get 'order_management/download/:id', to: 'order_management#download', as: :order_management_download
  patch 'order_management/edit/:id', to: 'order_management#update'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  scope '/admin' do
    resources :sample_albums, :sample_pictures, :service_lookups
  end
  
#  resources :user, only: :show
  
  resources :pictures do
    collection do
      delete 'mass_delete'
    end
    member do
      patch 'update_rotation'
    end
  end
  
  resources :albums do
    member do
      get 'front_cover'
      patch 'update_front_cover'
      get 'view_only'
    end
    resources :orders, shallow: true do 
      member do
        get 'checkout'
        post 'confirm'
        post 'cancel'
      end
    end
    
    resources :photos do # :defaults => {:format => 'json'}
      collection do
        patch 'update_photos'
      end
      member do
       # get 'crop'
        post 'insert'
        post 'append'
        patch 'update_memo'
      end
    end 
  end

  get 'about' => 'welcome#about'
  get 'welcome' => 'welcome#index'
  get 'learn_more' => 'home#learn_more'
  
  root to: 'home#index'

end
