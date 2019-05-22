Rails.application.routes.draw do
  get '/:locale' => 'top#index'
  root 'top#index'

  scope '/:locale' do
    resources :images, :devotions, :audios, :videos
    resources :photos
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
