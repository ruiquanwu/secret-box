Rails.application.routes.draw do

  devise_for :users
  resources :diaries
  
  resources :sample_albums
  
  resources :albums do
    get 'test'
    resources :freephotos
    resources :photos do
      member do
        get 'crop'
        post 'insert'
        post 'append'
        patch 'update_memo'
      end
    end 
  end

  get 'about' => 'welcome#about'
  get 'welcome' => 'welcome#index'
  
  root to: 'home#index'

end
