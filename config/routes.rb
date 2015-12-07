Rails.application.routes.draw do
  devise_for :users
  resources :diaries

  get 'about' => 'welcome#about'
  get 'welcome' => 'welcome#index'
  
  root to: 'home#index'

end
