Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    get 'signup', to: 'users/registrations#new'
    get 'login', to: 'users/sessions#new'
    post 'login', to: 'users/sessions#create'
    delete 'logout', to: 'users/sessions#destroy'
    get 'users/:id/edit', to: 'users/registrations#edit', :as => :edit_user
    put 'users/:id', to: 'users/registrations#update', :as => :user_update
    delete 'users/:id', to: 'users/registrations#destroy', :as => :user_destroy
  end
  devise_for :users, skip: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :favorite_games, only: [:index, :update]
  
  resources :users, only: [:index, :show]

  get 'users/:id/typing', to: 'users#typing_new'
  post 'users/:id/typing', to: 'users#typing_create', :as => :typing
  

  get 'admins' => 'users#admins', as: :admins
  

  # Provide mapping between URLs/HTTP verbs to controller
  resources :games do
    resources :reviews
    
    member do
      put 'like' => 'games#like'
      put 'dislike' => 'games#dislike'
      get :launch
    end

    collection do
      get 'download_loader', to: 'games#download_loader'
      get ':file_name', to: 'games#unity_build_files', file_name: /[A-Za-z0-9_-]{1,50}[.](data|wasm)[.](unityweb|code|framework)[.]{0,1}(unityweb){0,1}/
    end
  end
  
  resources :friendships

  resources :invitefriend
  resources :invitetoplaygame
  resources :contactdev
  resources :contactadm

  root to: 'games#index'
end
