Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    get 'signup', to: 'users/registrations#new'
    get 'login', to: 'users/sessions#new'
    post 'login', to: 'users/sessions#create'
    delete 'logout', to: 'users/sessions#destroy'
  end
  devise_for :users, skip: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show]
  

  # Provide mapping between URLs/HTTP verbs to controller
  resources :games do
    resources :reviews
    
    member do
      put 'like' => 'games#like'
      put 'dislike' => 'games#dislike'
      patch :launch
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

  root to: 'games#index'
end
