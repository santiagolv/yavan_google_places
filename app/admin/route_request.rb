ActiveAdmin.register RouteRequest do

 permit_params :origin_query, :origin_city, :origin_place, :origin_google_id, :destination_query, :destination_city, :destination_place, :destination_google_id, :destination_arrival_date_time, :max_time_in_advance, :user_id, :origin_google_suggested_departure_time

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
