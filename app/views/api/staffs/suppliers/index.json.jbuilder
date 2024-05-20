json.partial! 'api/components/status'
json.data do
  json.array! @suppliers do |supplier|
    json.id supplier.id
    json.logo supplier.logo
    json.name supplier.name
  end
end

json.pager pager_meta(@pagy)
