class CreateRoutePoolings < ActiveRecord::Migration
  def change
    create_table :route_poolings do |t|
      t.datetime :destination_arrival_date_time
      t.string :origin_place
      t.string :origin_city
      t.string :origin_google_id
      t.string :destination_place
      t.string :destination_city
      t.string :destination_google_id
      t.integer :user_id
      t.integer :route_request_id
      t.integer :passengers_pooled
      t.integer :average_buffer_time
      t.datetime :origin_departure_time
      t.boolean :confirmed_route

      t.timestamps

    end
  end
end
