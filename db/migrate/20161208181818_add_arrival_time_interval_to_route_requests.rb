class AddArrivalTimeIntervalToRouteRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :route_requests, :destination_arrival_time_interval, :string
    add_column :route_poolings, :destination_arrival_time_interval, :string
  end
end
