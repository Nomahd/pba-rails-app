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

  get '/api/:today', to: 'api#today'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
