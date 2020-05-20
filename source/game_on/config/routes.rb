Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Provide mapping between URLs/HTTP verbs to controller
  resources :games do
    member do
      patch :launch
    end

    collection do
      get 'download_loader', to: 'games#download_loader'
      get ':file_name', to: 'games#unity_code', file_name: /[A-Z,a-z,0-9]{1,33}.wasm.code.unityweb/
      get ':file_name', to: 'games#unity_framework', file_name: /[A-Z,a-z,0-9]{1,33}.wasm.framework.unityweb/
      get ':file_name', to: 'games#unity_data', file_name: /[A-Z,a-z,0-9]{1,33}.data.unityweb/
=begin
      get 'Desktop.wasm.code.unityweb', to: 'games#unity_code'
      get 'Desktop.wasm.framework.unityweb', to: 'games#unity_framework'
      get 'Desktop.data.unityweb', to: 'games#unity_data'
=end
    end
  end
  
  resources :users
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'logins#new', as: 'login'
  post 'login', to: 'logins#create', as: 'new_login'
  get 'logout', to: 'logins#destroy', as: 'logout'

  root :to => redirect('/games')
end
