Face::Application.routes.draw do
  
  root :to => 'sessions#new'

  resources :users, :sessions

  match '/logout' => 'sessions#destroy'

end
