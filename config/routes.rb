Rails.application.routes.draw do

  get '/:locale' => 'top#index'
  root 'top#index'

  scope '/:locale' do
    resources :images, :devotions, :audios, :videos do
      collection do
        get :bulk, :search, :summary
        post :bulk, action: :bulk_submit
        post :destroy_selected
      end
    end

    resources :people, :programs
    resources :photos

    if Rails.env.development?
      get 'view_tester/test'
    end
  end

  namespace :api do
    get 'today-all', to: 'today_all'
    get 'today', to: 'today'
    get 'batch', to: 'batch'
    get 'search', to: 'search'
    get 'select', to: 'select'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
