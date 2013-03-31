Tattletale::Application.routes.draw do
  resources :services
  resources :sessions
  resources :users

  get '/login' => 'sessions#new', :as => :login
  match '/logout' => 'sessions#destroy', :as => :logout

  get '/signup', to: 'users#new', :as => 'signup'

  post '/service/toggle/:id' => 'services#toggle', :as => :toggle

  delete '/account/destroy' => 'users#destroy'
  get '/account' => 'users#edit', :as => 'account'

  get '/dashboard' => 'dashboard#index'

  match '/:url' => 'services#checkin'

  root :to => redirect('/dashboard')

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
