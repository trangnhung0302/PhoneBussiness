json.partial! 'api/components/status'
json.data do
  json.array! @staffs do |staff|
    json.id staff.id
    json.name staff.name
    json.email staff.email
    json.phone staff.phone
    json.status staff.status
  end
end

json.pager pager_meta(@pagy)
