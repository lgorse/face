Face::Application.routes.draw do
  
  root :to => 'sessions#new'

  resources :users, :sessions
  resources :relationships, :only => [:create, :destroy]

  match '/logout' => 'sessions#destroy'

end
