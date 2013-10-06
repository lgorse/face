Face::Application.routes.draw do
  
  root :to => 'sessions#new'

  resources :users do
  	member do
  		get :friends
  	end

  end
  resources :sessions
  resources :relationships, :only => [:create, :destroy]
  resources :posts, :only => [:create, :destroy]

  match '/logout' => 'sessions#destroy'

end
