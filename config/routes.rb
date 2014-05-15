Rails.application.routes.draw do

  # Main page
  root to: 'welcome#index'

  concern :pageable do
    get 'page/:page', :action => :index, on: :collection
  end

  concern :userable do
    get 'user/:user_id', on: :collection
  end

  devise_for :users

  # Routes for users and their profiles
  get 'users' => 'users#index'
  get 'user/:id' => 'users#show', as: :user
  get 'profile/edit' => 'users#edit', as: :profile
  patch 'profile/edit' => 'users#update'

  scope :path => '/:commentable_type/:commentable_id' do
    resources :comments, only: :create
  end

  resources :comments, except: :create


  # TODO Надо отрефакторить вложенные геты — у них одинаковые параметры страниц.
  resources :questions, concerns: [:pageable] do
    collection do
      get 'featured(/page/:page)' => 'questions#featured', as: :featured
      get 'popular(/page/:page)' => 'questions#popular', as: :popular
      get 'unanswered(/page/:page)' => 'questions#unanswered', as: :unanswered
      get 'tags/:tag', to: 'questions#index', as: :tag
    end
    resources :answers
  end

end
