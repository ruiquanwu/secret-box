Rails.application.routes.draw do

  get 'sample_albums/new'

  get 'sample_albums/edit'

  get 'sample_albums/index'

  get 'free_photos/index'

  get 'free_photos/new'

  devise_for :users
  resources :diaries
  
  resources :sample_albums
  
  resources :albums do
    get 'album_manager_new', on: :collection
    post 'album_manager_create', on: :collection
    get 'album_manager_index', on: :collection

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
