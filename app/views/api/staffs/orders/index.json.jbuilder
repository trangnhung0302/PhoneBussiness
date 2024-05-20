json.partial! 'api/components/status'
json.data do
  json.array! @orders do |order|
    json.id order.id
    json.order_number order.order_number
    json.customer_name order.customer.name
    json.payment_status order.payment_status
    json.status order.status
    json.staff_name order.staff && order.staff.name
    json.created_at order.created_at
  end
end

json.pager pager_meta(@pagy)
