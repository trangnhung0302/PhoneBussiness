json.partial! 'api/components/status'
json.data do
  json.array! @payment_types do |payment_type|
    json.id payment_type.id
    json.name payment_type.name
  end
end