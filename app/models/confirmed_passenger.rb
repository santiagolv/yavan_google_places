class ConfirmedPassenger < ApplicationRecord
  # Direct associations

  belongs_to :route_pool,
             :class_name => "RoutePooling"

  belongs_to :user

  # Indirect associations

  # Validations

end
