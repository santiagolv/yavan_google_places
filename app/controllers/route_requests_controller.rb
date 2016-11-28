require 'open-uri'
require 'json'

class RouteRequestsController < ApplicationController
  before_action :current_user_must_be_route_request_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_route_request_user
    route_request = RouteRequest.find(params[:id])

    unless current_user == route_request.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = RouteRequest.ransack(params[:q])
    @route_requests = @q.result(:distinct => true).includes(:user, :route_pooling).page(params[:page]).per(10)

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

  def new_origin
    @origin_request = String.new
    render("route_requests/new_origin" )
  end

  def origin_validation
    @origin_request = params[:user_origin_request]
    @destination_request = params[:user_destination_request]

    @origin_request_no_space = URI.encode(@origin_request)
    @destination_request_no_space = URI.encode(@destination_request)
    @url_origin = "https://maps.googleapis.com/maps/api/geocode/json?address="+@origin_request_no_space+"&key=AIzaSyBXz-26sirAvveXXvj354ayAJY6lpq_JAw"
    @url_destination = "https://maps.googleapis.com/maps/api/geocode/json?address="+@destination_request_no_space+"&key=AIzaSyBXz-26sirAvveXXvj354ayAJY6lpq_JAw"
    @parsed_data_origin = JSON.parse(open(@url_origin).read)
    @parsed_data_destination = JSON.parse(open(@url_destination).read)
    @status_origin = @parsed_data_origin["status"]
    @status_destination = @parsed_data_destination["status"]
    if @status_origin!="OK"
      redirect_to(:back, :notice=>"Origin Not Found, Please Try Again." )
    elsif @status_destination!="OK"
      redirect_to(:back, :notice=>"Destination Not Found, Please Try Again." )
    else
      @google_id_origin = @parsed_data_origin["results"][0]["place_id"]
      @google_id_destination = @parsed_data_destination["results"][0]["place_id"]
      render("route_requests/route_validation" )
    end
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
