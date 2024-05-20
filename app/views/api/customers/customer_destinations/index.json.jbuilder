json.partial! 'api/components/status'
json.data do
  json.array! @customer_destinations do |customer_destination|
    json.id customer_destination.id
    json.customer_id customer_destination.customer_id
    json.recipient_name customer_destination.recipient_name
    json.recipient_phone customer_destination.recipient_phone
    json.province_id customer_destination.province_id
    json.province_name customer_destination.province_name
    json.district_id customer_destination.district_id
    json.district_name customer_destination.district_name
    json.ward_code customer_destination.ward_code
    json.ward_name customer_destination.ward_name
    json.address customer_destination.address
    json.default customer_destination.default
  end
end
