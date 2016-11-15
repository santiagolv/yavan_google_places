class RouteRequest < ApplicationRecord
  # Direct associations

  has_one    :route_pooling,
             :dependent => :destroy

  belongs_to :user

  # Indirect associations

  # Validations

end
