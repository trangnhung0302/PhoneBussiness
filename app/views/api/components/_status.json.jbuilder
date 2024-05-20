status = @status || 'OK'
message = @message || ''
json.result do
  json.status status
  json.message message
end
