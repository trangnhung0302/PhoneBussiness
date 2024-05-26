json.partial! 'api/components/status'
json.data do
  json.id @current_customer.id
  json.email @current_customer.email
  json.name @current_customer.name
  json.phone @current_customer.phone
end