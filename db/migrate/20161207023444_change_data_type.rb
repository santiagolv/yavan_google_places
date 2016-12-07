class ChangeDataType < ActiveRecord::Migration[5.0]
  def change
    change_column(:route_requests, :origin_google_id, :string)
    change_column(:route_requests, :origin_google_suggested_departure_time, :datetime)
  end
end
