json.partial! 'api/components/status'
json.data do
  json.id @supplier.id
  json.logo @supplier.logo
  json.name @supplier.name
end
