json.partial! 'api/components/status'
json.data do
  json.array! @order_cancel_reasons do |order_cancel_reason|
    json.id order_cancel_reason.id
    json.name order_cancel_reason.name
  end
end
