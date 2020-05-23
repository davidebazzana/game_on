Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :games do 
    resources :reviews
  end

  # Provide mapping between URLs/HTTP verbs to controller
  resources :games do
    member do 
      put 'like' => 'games#like'
      put 'dislike' => 'games#dislike'
    end
  end

  resources :users
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'logins#new', as: 'login'
  post 'login', to: 'logins#create', as: 'new_login'
  get 'logout', to: 'logins#destroy', as: 'logout'

  root :to => redirect('/games')
end
