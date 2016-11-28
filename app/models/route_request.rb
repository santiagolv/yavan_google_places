class RouteRequest < ApplicationRecord
  # Direct associations

  has_one    :route_pooling,
  :dependent => :destroy

  belongs_to :user

  # Indirect associations

  # Validations
  #  validates :user_id, :presence=>true Not sure, what about users that have not logged in?
  validates :origin_google_id, :presence=>true
  validates :destination_google_id, :presence=>true
  validates :destination_arrival_date_time, :presence=>true
end
