json.partial! 'api/components/status'

json.data do
  json.order_number @order.order_number
  json.total_price @order.total_price
  json.ship_amount @order.ship_amount
  json.message @order.message
  json.status @order.status
  json.payment_status @order.payment_status
  json.transport_service_name @order.transport_service_name
  json.created_at @order.created_at
  json.customer_destination do
  customer_destination = @order.customer_destination
    json.recipient_name customer_destination.recipient_name
    json.recipient_phone customer_destination.recipient_phone
    json.province_name customer_destination.province_name
    json.district_name customer_destination.district_name
    json.ward_name customer_destination.ward_name
    json.address customer_destination.address
  end
  json.payment_type @order.payment_type.name
  json.customer_email @order.customer.email
  json.customer_name @order.customer.name
  json.items do
    json.array! @order.order_items do |order_item|
      item = order_item.item
      json.price order_item.price
      json.quantity order_item.quantity
      json.item_name item.name
      json.item_image item.item_images.first && item.item_images.first.image_url
    end
  end
end
