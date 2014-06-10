Rails.application.routes.draw do

  # Main page
  root to: 'welcome#index'

  concern :pageable do
    get 'page/:page', :action => :index, on: :collection
  end

  concern :userable do
    get 'user/:user_id', on: :collection
  end


  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/add_email' => 'users#add_email', via: [:get, :patch, :post], as: :add_user_email

  # todo resources
  # Routes for users and their profiles
  get 'users' => 'users#index'
  get 'user/:id' => 'users#show', as: :user
  get 'profile/edit' => 'users#edit', as: :profile
  patch 'profile/edit' => 'users#update'

  # Comments
  concern :commentable do
    resources :comments
  end
  resources :comments

  # Voting
  concern :votable do
    post 'like' => 'votes#like', as: :like
    post 'unlike' => 'votes#unlike', as: :unlike
    delete 'dislike' => 'votes#destroy', as: :dislike
  end

  # TODO Надо отрефакторить вложенные геты — у них одинаковые параметры страниц.
  resources :questions, concerns: [:pageable, :votable, :commentable] do
    collection do
      get 'featured(/page/:page)' => 'questions#featured', as: :featured
      get 'popular(/page/:page)' => 'questions#popular', as: :popular
      get 'unanswered(/page/:page)' => 'questions#unanswered', as: :unanswered
      get 'tags/:tag', to: 'questions#index', as: :tag
    end
    resources :answers
  end

  resources :answers, only: [], concerns: [:votable, :commentable]

  resources :attachments, only: [:create, :destroy]




end
