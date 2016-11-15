class RoutePooling < ApplicationRecord
  # Direct associations

  has_many   :confirmed_passengers,
             :foreign_key => "route_pool_id",
             :dependent => :destroy

  belongs_to :route_request

  # Indirect associations

  # Validations

end
