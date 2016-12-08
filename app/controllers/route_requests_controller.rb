require 'open-uri'
require 'json'
require 'openssl'
require 'time'
require 'date'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE



class RouteRequestsController < ApplicationController
  before_action :current_user_must_be_route_request_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_route_request_user
    route_request = RouteRequest.find(params[:id])

    unless current_user == route_request.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @route_requests =RouteRequest.all
    @route_requests.each do |route_request|
    route_request.origin_departure_date = route_request.origin_google_suggested_departure_time.to_date.to_s
    route_request.save
  end
    render("route_requests/index.html.erb")
  end

  def show
    @route_request = RouteRequest.find(params[:id])

    render("route_requests/show.html.erb")
  end

  def new
    render("route_requests/new" )
  end

  def route_validation
    @origin_request = params[:user_origin_request]
    @destination_request = params[:user_destination_request]
    @date_time_departure = params[:date_time_departure]
    @date_time = DateTime.parse(@date_time_departure).to_time.to_i

    @date_time_to_s = @date_time.to_s
    @date_time_google = @date_time+3600*6

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
      #Origin Parametes
      @google_id_origin = @parsed_data_origin["results"][0]["place_id"]
      @origin_city = @parsed_data_origin["results"][0]["address_components"][1]["long_name"]
      @origin_formatted_address = @parsed_data_origin["results"][0]["formatted_address"]
      @origin_lat =  @parsed_data_origin["results"][0]["geometry"]["location"]["lat"]
      @origin_long =  @parsed_data_origin["results"][0]["geometry"]["location"]["lng"]

      #Destination Parameters
      @google_id_destination = @parsed_data_destination["results"][0]["place_id"]
      @destination_city = @parsed_data_destination["results"][0]["address_components"][1]["long_name"]
      @destination_formatted_address = @parsed_data_destination["results"][0]["formatted_address"]
      @destination_lat =  @parsed_data_destination["results"][0]["geometry"]["location"]["lat"]
      @destination_long =  @parsed_data_destination["results"][0]["geometry"]["location"]["lng"]

      #API into Directions to extract travel times
      @url_directions = "https://maps.googleapis.com/maps/api/directions/json?&origin=place_id:"+@google_id_origin.to_s+"&destination=place_id:"+@google_id_destination.to_s+"&departure_time="+@date_time_google.to_s+"&key=AIzaSyA5xDoZA9AbMjYNiGqtq3nSe6lnb044fq4"
      @parsed_data_directions = JSON.parse(open(@url_directions).read)
      @duration_in_traffic = Array.new
      @duration_in_traffic[0] = @parsed_data_directions["routes"][0]["legs"][0]["duration_in_traffic"]["value"]
      @duration_in_traffic[1] = @parsed_data_directions["routes"][0]["legs"][0]["duration_in_traffic"]["text"]
      @duration = @parsed_data_directions["routes"][0]["legs"][0]["duration"]["text"]
      #same API but with pessimistic traffic mode
      @url_directions_pessimistic = "https://maps.googleapis.com/maps/api/directions/json?&origin=place_id:"+@google_id_origin.to_s+"&destination=place_id:"+@google_id_destination.to_s+"&departure_time="+@date_time_google.to_s+"&traffic_model=pessimistic"+"&key=AIzaSyA5xDoZA9AbMjYNiGqtq3nSe6lnb044fq4"
      @parsed_data_directions_pessimistic= JSON.parse(open(@url_directions_pessimistic).read)
      @duration_in_traffic[2] = @parsed_data_directions_pessimistic["routes"][0]["legs"][0]["duration_in_traffic"]["value"]
      @duration_in_traffic[3] = @parsed_data_directions_pessimistic["routes"][0]["legs"][0]["duration_in_traffic"]["text"]
      # Duration Time
      @max_duration = (@duration_in_traffic[0].to_i+@duration_in_traffic[2].to_i)/2
      @date_time_arrival = (@date_time.to_i+@max_duration.to_i)
      @date_time_arrival_formatted = DateTime.strptime(@date_time_arrival.to_s,'%s')
      render("route_requests/route_validation")
    end
  end

  def create
    @route_request = RouteRequest.new

    @route_request.origin_query = params[:origin_query]
    @route_request.origin_city = params[:origin_city]
    @route_request.origin_place = params[:origin_formatted_address]
    @route_request.origin_google_id = params[:google_id_origin] # Field not updating!!!
    @route_request.destination_query = params[:destination_query]
    @route_request.destination_city = params[:destination_city]
    @route_request.destination_place = params[:destination_formatted_address]
    @route_request.destination_google_id = params[:google_id_destination]
    @route_request.destination_arrival_date_time = params[:destination_arrival_date_time]
    @route_request.user_id = params[:user_id]
    @route_request.origin_google_suggested_departure_time = params[:origin_google_suggested_departure_time]

    @route_request.save

    save_status = @route_request.save
    render("/route_requests/index.html.erb")
    #if save_status == true
    #  referer = URI(request.referer).path

    #  case referer
    #  when "/route_requests/new", "/create_route_request","create_origin_request"
    #    redirect_to("/route_requests", :notice => "Route request created successfully.")
    #  else
    #    redirect_back(:fallback_location => "/", :notice => "Route request created successfully.")
    #  end
    #else
    #  render("route_requests/new.html.erb")
    #end
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


    redirect_to("/route_requests", :notice => "Route request deleted.")


  end
end
