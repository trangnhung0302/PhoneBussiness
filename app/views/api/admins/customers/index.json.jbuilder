json.partial! 'api/components/status'
json.data do
  json.array! @customers do |customer|
    json.id customer.id
    json.name customer.name
    json.email customer.email
    json.phone customer.phone
    json.status customer.status
  end
end

json.pager pager_meta(@pagy)