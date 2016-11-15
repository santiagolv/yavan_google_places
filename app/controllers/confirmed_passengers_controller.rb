class ConfirmedPassengersController < ApplicationController
  def index
    @confirmed_passengers = ConfirmedPassenger.page(params[:page]).per(10)

    render("confirmed_passengers/index.html.erb")
  end

  def show
    @confirmed_passenger = ConfirmedPassenger.find(params[:id])

    render("confirmed_passengers/show.html.erb")
  end

  def new
    @confirmed_passenger = ConfirmedPassenger.new

    render("confirmed_passengers/new.html.erb")
  end

  def create
    @confirmed_passenger = ConfirmedPassenger.new

    @confirmed_passenger.route_pool_id = params[:route_pool_id]
    @confirmed_passenger.user_id = params[:user_id]
    @confirmed_passenger.passenger_name = params[:passenger_name]
    @confirmed_passenger.passenger_last_name = params[:passenger_last_name]

    save_status = @confirmed_passenger.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/confirmed_passengers/new", "/create_confirmed_passenger"
        redirect_to("/confirmed_passengers")
      else
        redirect_back(:fallback_location => "/", :notice => "Confirmed passenger created successfully.")
      end
    else
      render("confirmed_passengers/new.html.erb")
    end
  end

  def edit
    @confirmed_passenger = ConfirmedPassenger.find(params[:id])

    render("confirmed_passengers/edit.html.erb")
  end

  def update
    @confirmed_passenger = ConfirmedPassenger.find(params[:id])

    @confirmed_passenger.route_pool_id = params[:route_pool_id]
    @confirmed_passenger.user_id = params[:user_id]
    @confirmed_passenger.passenger_name = params[:passenger_name]
    @confirmed_passenger.passenger_last_name = params[:passenger_last_name]

    save_status = @confirmed_passenger.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/confirmed_passengers/#{@confirmed_passenger.id}/edit", "/update_confirmed_passenger"
        redirect_to("/confirmed_passengers/#{@confirmed_passenger.id}", :notice => "Confirmed passenger updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Confirmed passenger updated successfully.")
      end
    else
      render("confirmed_passengers/edit.html.erb")
    end
  end

  def destroy
    @confirmed_passenger = ConfirmedPassenger.find(params[:id])

    @confirmed_passenger.destroy

    if URI(request.referer).path == "/confirmed_passengers/#{@confirmed_passenger.id}"
      redirect_to("/", :notice => "Confirmed passenger deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Confirmed passenger deleted.")
    end
  end
end
