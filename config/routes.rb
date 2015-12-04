Rails.application.routes.draw do
  devise_for :users
  resources :diaries

  get 'about' => 'welcome#about'
  
  root to: 'welcome#index'

end
