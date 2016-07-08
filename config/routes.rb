Rails.application.routes.draw do

  get 'order_management/index'

  get 'order_management/show'

  devise_for :users
  resources :diaries
  
  resources :sample_albums
  resources :sample_pictures
  resources :service_lookups
  
  resources :albums do
   get 'show_json', defaults: { format: 'json' }
    get 'test' => 'test#index'
    member do
      get 'order'
    end
    resources :orders do
      member do
        get 'checkout'
        post 'confirm'
      end
    end
    
    resources :photos do # :defaults => {:format => 'json'}
      collection do
        patch 'update_photos'
      end
      member do
        get 'crop'
        post 'insert'
        post 'append'
      end
    end 
  end

  get 'about' => 'welcome#about'
  get 'welcome' => 'welcome#index'
  
  root to: 'home#index'

end
