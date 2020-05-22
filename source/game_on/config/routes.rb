Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Provide mapping between URLs/HTTP verbs to controller
  resources :games do
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
  
  resources :users
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'logins#new', as: 'login'
  post 'login', to: 'logins#create', as: 'new_login'
  get 'logout', to: 'logins#destroy', as: 'logout'

  root :to => redirect('/games')
end
