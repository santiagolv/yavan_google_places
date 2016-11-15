class RouteRequestsController < ApplicationController
  before_action :current_user_must_be_route_request_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_route_request_user
    route_request = RouteRequest.find(params[:id])

    unless current_user == route_request.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @route_requests = RouteRequest.page(params[:page]).per(10)

    render("route_requests/index.html.erb")
  end

  def show
    @route_request = RouteRequest.find(params[:id])

    render("route_requests/show.html.erb")
  end

  def new
    @route_request = RouteRequest.new

    render("route_requests/new.html.erb")
  end

  def create
    @route_request = RouteRequest.new

    @route_request.origin_query = params[:origin_query]
    @route_request.origin_city = params[:origin_city]
    @route_request.origin_place = params[:origin_place]
    @route_request.origin_google_id = params[:origin_google_id]
    @route_request.destination_query = params[:destination_query]
    @route_request.destination_city = params[:destination_city]
    @route_request.destination_place = params[:destination_place]
    @route_request.destination_google_id = params[:destination_google_id]
    @route_request.destination_arrival_date_time = params[:destination_arrival_date_time]
    @route_request.max_time_in_advance = params[:max_time_in_advance]
    @route_request.user_id = params[:user_id]
    @route_request.origin_google_suggested_departure_time = params[:origin_google_suggested_departure_time]

    save_status = @route_request.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/route_requests/new", "/create_route_request"
        redirect_to("/route_requests")
      else
        redirect_back(:fallback_location => "/", :notice => "Route request created successfully.")
      end
    else
      render("route_requests/new.html.erb")
    end
  end

  def edit
    @route_request = RouteRequest.find(params[:id])

    render("route_requests/edit.html.erb")
  end

  def update
    @route_request = RouteRequest.find(params[:id])

    @route_request.origin_query = params[:origin_query]
    @route_request.origin_city = params[:origin_city]
    @route_request.origin_place = params[:origin_place]
    @route_request.origin_google_id = params[:origin_google_id]
    @route_request.destination_query = params[:destination_query]
    @route_request.destination_city = params[:destination_city]
    @route_request.destination_place = params[:destination_place]
    @route_request.destination_google_id = params[:destination_google_id]
    @route_request.destination_arrival_date_time = params[:destination_arrival_date_time]
    @route_request.max_time_in_advance = params[:max_time_in_advance]
    @route_request.user_id = params[:user_id]
    @route_request.origin_google_suggested_departure_time = params[:origin_google_suggested_departure_time]

    save_status = @route_request.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/route_requests/#{@route_request.id}/edit", "/update_route_request"
        redirect_to("/route_requests/#{@route_request.id}", :notice => "Route request updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Route request updated successfully.")
      end
    else
      render("route_requests/edit.html.erb")
    end
  end

  def destroy
    @route_request = RouteRequest.find(params[:id])

    @route_request.destroy

    if URI(request.referer).path == "/route_requests/#{@route_request.id}"
      redirect_to("/", :notice => "Route request deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Route request deleted.")
    end
  end
end
