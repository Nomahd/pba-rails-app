Rails.application.routes.draw do

  get '/:locale' => 'top#index'
  root 'top#index'

  scope '/:locale' do
    resources :images, :devotions, :audios, :videos do
      collection do
        get :bulk
        post :bulk, action: :bulk_submit
      end
    end

    resources :messengers
    resources :photos

    if Rails.env.development?
      get 'view_tester/test'
    end

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
