class AddDepartureIDtpPoolings < ActiveRecord::Migration[5.0]
  def change
    add_column :route_poolings, :destination_google_id, :string
  end
end
