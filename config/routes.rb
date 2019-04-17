Rails.application.routes.draw do
  resources :devotions
  resources :audios
  resources :videos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'top#index'
end
