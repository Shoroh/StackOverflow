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

  concern :commentable do
    resources :comments, only: [:create]
  end

  # TODO Надо отрефакторить вложенные геты — у них одинаковые параметры страниц.
  resources :questions, concerns: [:pageable, :commentable] do
    collection do
      get 'featured(/page/:page)' => 'questions#featured', as: :featured
      get 'popular(/page/:page)' => 'questions#popular', as: :popular
      get 'unanswered(/page/:page)' => 'questions#unanswered', as: :unanswered
      get 'tags/:tag', to: 'questions#index', as: :tag
    end
    resources :answers, only: [:create], concerns: :commentable
  end

end
