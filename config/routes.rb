Rails.application.routes.draw do
  devise_for :users
  resources :diarys

  get 'about' => 'welcome#about'
  
  root to: 'welcome#index'

end
