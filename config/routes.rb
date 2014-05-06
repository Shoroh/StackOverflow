Rails.application.routes.draw do

  # Main page
  root to: 'welcome#index'

  concern :pageable do
    get 'page/:page', :action => :index, on: :collection
  end

  devise_for :users

  # Routes for users and their profiles
  get 'users' => 'users#index'
  get 'user/:id' => 'users#show', as: :user
  get 'profile/edit' => 'users#edit', as: :profile
  patch 'profile/edit' => 'users#update'


  resources :questions, concerns: :pageable do
    get 'featured(/page/:page)' => 'questions#featured', on: :collection, as: :featured
  end

end
