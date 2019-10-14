Rails.application.routes.draw do

  get '/:locale' => 'top#index'
  root 'top#index'

  scope '/:locale' do
    resources :devotions, :audios, :videos do
      collection do
        get :bulk, :search, :summary, :bulk_progress
        post :bulk_execute, :bulk_submit
        post :destroy_selected
      end
    end

    scope :options do
      get '/', to: 'options#index', as: :options
      get 'delete', to: 'options#delete', as: :options_delete
      get 'delete_progress', to: 'options#delete_progress', as: :options_delete_progress
      post 'delete_audios', to: 'options#delete_audios', as: :options_delete_audios
      post 'delete_videos', to: 'options#delete_videos', as: :options_delete_videos
      post 'delete_devotions', to: 'options#delete_devotions', as: :options_delete_devotions
      resources :tag_meta, :people, :programs, :schedule do
        collection do
          post :quick_create
          post :destroy_selected
        end
      end

    end

    if Rails.env.development?
      get 'view_tester/test'
      get 'view_tester/async'
    end
  end

  namespace :api do
    get 'today-all'
    get 'today'
    get 'batch'
    get 'search'
    get 'select'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
