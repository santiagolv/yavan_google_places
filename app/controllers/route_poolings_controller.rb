class RoutePoolingsController < ApplicationController
  def index
    @route_poolings = RoutePooling.page(params[:page]).per(10)

    render("route_poolings/index.html.erb")
  end

  def show
    @confirmed_passenger = ConfirmedPassenger.new
    @route_pooling = RoutePooling.find(params[:id])

    render("route_poolings/show.html.erb")
  end

  def new
    @route_pooling = RoutePooling.new

    render("route_poolings/new.html.erb")
  end

  def create
    @route_pooling = RoutePooling.new

    @route_pooling.arrival_date_time = params[:arrival_date_time]
    @route_pooling.origin_place = params[:origin_place]
    @route_pooling.origin_city = params[:origin_city]
    @route_pooling.origin_google_id = params[:origin_google_id]
    @route_pooling.destination_place = params[:destination_place]
    @route_pooling.destination_city = params[:destination_city]
    @route_pooling.user_id = params[:user_id]
    @route_pooling.route_request_id = params[:route_request_id]
    @route_pooling.passengers_pooled = params[:passengers_pooled]
    @route_pooling.average_buffer_time = params[:average_buffer_time]
    @route_pooling.google_suggested_departure_time = params[:google_suggested_departure_time]
    @route_pooling.confirmed_route = params[:confirmed_route]

    save_status = @route_pooling.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/route_poolings/new", "/create_route_pooling"
        redirect_to("/route_poolings")
      else
        redirect_back(:fallback_location => "/", :notice => "Route pooling created successfully.")
      end
    else
      render("route_poolings/new.html.erb")
    end
  end

  def edit
    @route_pooling = RoutePooling.find(params[:id])

    render("route_poolings/edit.html.erb")
  end

  def update
    @route_pooling = RoutePooling.find(params[:id])

    @route_pooling.arrival_date_time = params[:arrival_date_time]
    @route_pooling.origin_place = params[:origin_place]
    @route_pooling.origin_city = params[:origin_city]
    @route_pooling.origin_google_id = params[:origin_google_id]
    @route_pooling.destination_place = params[:destination_place]
    @route_pooling.destination_city = params[:destination_city]
    @route_pooling.user_id = params[:user_id]
    @route_pooling.route_request_id = params[:route_request_id]
    @route_pooling.passengers_pooled = params[:passengers_pooled]
    @route_pooling.average_buffer_time = params[:average_buffer_time]
    @route_pooling.google_suggested_departure_time = params[:google_suggested_departure_time]
    @route_pooling.confirmed_route = params[:confirmed_route]

    save_status = @route_pooling.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/route_poolings/#{@route_pooling.id}/edit", "/update_route_pooling"
        redirect_to("/route_poolings/#{@route_pooling.id}", :notice => "Route pooling updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Route pooling updated successfully.")
      end
    else
      render("route_poolings/edit.html.erb")
    end
  end

  def destroy
    @route_pooling = RoutePooling.find(params[:id])

    @route_pooling.destroy

    if URI(request.referer).path == "/route_poolings/#{@route_pooling.id}"
      redirect_to("/", :notice => "Route pooling deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Route pooling deleted.")
    end
  end
end
