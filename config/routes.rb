Rails.application.routes.draw do

  devise_for :users
  resources :diaries
  
  resources :sample_albums
  
  resources :albums do
   get 'show_json', defaults: { format: 'json' }
    get 'test' => 'test#index'
    resources :freephotos
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
