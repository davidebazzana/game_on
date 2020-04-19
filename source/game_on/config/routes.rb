Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Provide mapping between URLs/HTTP verbs to controller
  resources :games
end
