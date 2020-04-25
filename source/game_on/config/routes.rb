Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Provide mapping between URLs/HTTP verbs to controller
  resources :games
  resources :users
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'logins#new', as: 'login'

  root :to => redirect('/games')
end
