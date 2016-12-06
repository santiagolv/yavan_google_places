class CreateRouteRequests < ActiveRecord::Migration
  def change
    create_table :route_requests do |t|
      t.text :origin_query
      t.text :origin_city
      t.text :origin_place #Google formatted address
      t.text :origin_google_id
      t.text :destination_query
      t.text :destination_city
      t.text :destination_place
      t.text :destination_google_id
      t.text :destination_arrival_date_time
      t.time :max_time_in_advance
      t.integer :user_id
      t.text :origin_google_suggested_departure_time #cambiar a origin_departure_date_time

      t.timestamps

    end
  end
end
