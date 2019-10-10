Rails.application.routes.draw do

  resources :bulks
  get 'tag/create'
  get 'tag_controller/create'
  get 'tag_meta/create'
  get '/:locale' => 'top#index'
  root 'top#index'

  scope '/:locale' do
    resources :images, :devotions, :audios, :videos, :bulks do
      collection do
        get :bulk, :search, :summary, :bulk_progress
        post :bulk_execute, :bulk_submit
        post :destroy_selected
      end
    end

    resources :people, :programs, :tag_meta
    resources :photos

    if Rails.env.development?
      get 'view_tester/test'
      get 'view_tester/async'
    end

    get 'options', to: 'options#index'
    get 'options/delete'
    get 'options/delete_progress'
    post 'options/delete_audios'
    post 'options/delete_videos'
    post 'options/delete_devotions'
    get 'options/people'
    get 'options/tags'
    get 'options/schedule'
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
