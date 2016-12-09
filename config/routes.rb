Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "route_requests#new"
  # Routes for the Confirmed_passenger resource:
  # CREATE
  get "/confirmed_passengers/new", :controller => "confirmed_passengers", :action => "new"
  post "/create_confirmed_passenger", :controller => "confirmed_passengers", :action => "create"

  # READ
  get "/confirmed_passengers", :controller => "confirmed_passengers", :action => "index"
  get "/confirmed_passengers/:id", :controller => "confirmed_passengers", :action => "show"

  # UPDATE
  get "/confirmed_passengers/:id/edit", :controller => "confirmed_passengers", :action => "edit"
  post "/update_confirmed_passenger/:id", :controller => "confirmed_passengers", :action => "update"

  # DELETE
  get "/delete_confirmed_passenger/:id", :controller => "confirmed_passengers", :action => "destroy"
  #------------------------------

  # Routes for the Route_pooling resource:
  # CREATE
  get "/route_poolings/new", :controller => "route_poolings", :action => "new"
  post "/create_route_pooling", :controller => "route_poolings", :action => "create"
  get "/poolings", :controller => "route_poolings", :action => "view"
  get "/my_poolings", :controller => "route_poolings", :action => "view_own"

  # READ
  get "/route_poolings", :controller => "route_poolings", :action => "index"
  get "/my_route_poolings", :controller => "route_poolings", :action => "my_index"
  get "/route_poolings/:id", :controller => "route_poolings", :action => "show"

  # UPDATE
  get "/route_poolings/:id/edit", :controller => "route_poolings", :action => "edit"
  post "/update_route_pooling/:id", :controller => "route_poolings", :action => "update"

  # DELETE
  get "/delete_route_pooling/:id", :controller => "route_poolings", :action => "destroy"
  #------------------------------

  # Routes for the Route_request resource:
  # CREATE
  get "/route_requests/new", :controller => "route_requests", :action => "new"
  get "/create_route_request", :controller => "route_requests", :action => "create"
  post "/route_validation", :controller => "route_requests", :action => "route_validation"

  # READ
  get "/route_requests", :controller => "route_requests", :action => "index"
  get "/route_requests/:id", :controller => "route_requests", :action => "show"

  # UPDATE
  get "/route_requests/:id/edit", :controller => "route_requests", :action => "edit"
  post "/update_route_request/:id", :controller => "route_requests", :action => "update"

  # DELETE
  get "/delete_route_request/:id", :controller => "route_requests", :action => "destroy"
  #------------------------------


  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
