class AddOriginDateToRouteRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :route_requests, :origin_departure_date, :string
    add_column :route_requests, :origin_departure_time, :string
    add_column :route_poolings, :origin_departure_date, :string
    add_column :route_poolings, :origin_departure_time, :string
    
  end
end
