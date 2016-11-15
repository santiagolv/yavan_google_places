ActiveAdmin.register RoutePooling do

 permit_params :arrival_date_time, :origin_place, :origin_city, :origin_google_id, :destination_place, :destination_city, :user_id, :route_request_id, :passengers_pooled, :average_buffer_time, :google_suggested_departure_time, :confirmed_route

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


end
