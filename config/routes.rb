Rails.application.routes.draw do
  root 'top#index'

  resources :devotions
  resources :audios
  resources :videos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
