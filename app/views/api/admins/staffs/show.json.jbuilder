json.partial! 'api/components/status'
json.data do
  json.id @staff.id
  json.name @staff.name
  json.email @staff.email
  json.phone @staff.phone
  json.status @staff.status
end
