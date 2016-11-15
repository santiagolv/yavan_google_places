class CreateConfirmedPassengers < ActiveRecord::Migration
  def change
    create_table :confirmed_passengers do |t|
      t.integer :route_pool_id
      t.integer :user_id
      t.string :passenger_name
      t.string :passenger_last_name

      t.timestamps

    end
  end
end
