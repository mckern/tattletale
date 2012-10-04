Tattletale::Application.routes.draw do
  resources :services

  match '/:url' => 'services#checkin'
  root :to => 'services#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
