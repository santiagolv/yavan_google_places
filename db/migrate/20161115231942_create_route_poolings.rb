class CreateRoutePoolings < ActiveRecord::Migration
  def change
    create_table :route_poolings do |t|
      t.datetime :arrival_date_time
      t.string :origin_place
      t.string :origin_city
      t.integer :origin_google_id
      t.string :destination_place
      t.string :destination_city
      t.integer :user_id
      t.integer :route_request_id
      t.integer :passengers_pooled
      t.integer :average_buffer_time
      t.time :google_suggested_departure_time
      t.boolean :confirmed_route

      t.timestamps

    end
  end
end
