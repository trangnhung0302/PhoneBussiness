json.partial! 'api/components/status'
json.data do
  json.array! @suppliers do |supplier|
    json.id supplier.id
    json.logo supplier.logo
    json.name supplier.name
    json.category_id supplier.category_id
  end
end
