Rails.application.routes.draw do
  # Routes for the Route_pooling resource:
  # CREATE
  get "/route_poolings/new", :controller => "route_poolings", :action => "new"
  post "/create_route_pooling", :controller => "route_poolings", :action => "create"

  # READ
  get "/route_poolings", :controller => "route_poolings", :action => "index"
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
  post "/create_route_request", :controller => "route_requests", :action => "create"

  # READ
  get "/route_requests", :controller => "route_requests", :action => "index"
  get "/route_requests/:id", :controller => "route_requests", :action => "show"

  # UPDATE
  get "/route_requests/:id/edit", :controller => "route_requests", :action => "edit"
  post "/update_route_request/:id", :controller => "route_requests", :action => "update"

  # DELETE
  get "/delete_route_request/:id", :controller => "route_requests", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the User resource:
  # READ
  get "/users", :controller => "users", :action => "index"
  get "/users/:id", :controller => "users", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
