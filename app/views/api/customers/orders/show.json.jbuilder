json.partial! 'api/components/status'
json.data do
  payment_type = @order.payment_type
  json.id @order.id
  json.order_number @order.order_number
  json.total_price @order.total_price
  json.ship_amount @order.ship_amount
  json.payment_status @order.payment_status
  json.status @order.status
  json.transport_service_id @order.transport_service_id
  json.transport_service_name @order.transport_service_name
  json.payment_type_id @order.payment_type_id
  json.destination do
    destination = @order.customer_destination
    json.id destination.id
    json.recipient_name destination.recipient_name
    json.recipient_phone destination.recipient_phone
    json.address destination.address
    json.ward_name destination.ward_name
    json.district_name destination.district_name
    json.province_name destination.province_name
  end

  json.order_items do
    json.array! @order.order_items do |order_item|
      item = order_item.item
      item_color = order_item.item_color
      json.item_id item.id
      json.item_color_id order_item.item_color_id
      json.item_name item.name
      json.color item_color && item_color.color
      json.quantity order_item.quantity
      json.item_price item_color.present? ? item_color.price : item.price
      json.item_purchase_price item_color.present? ? item_color.purchase_price : item.purchase_price
      json.item_images do
        json.array! item.item_images do |item_image|
          json.id item_image.id
          json.image_url item_image.image_url
        end
      end
      json.supplier_id item.supplier_id
      json.category_id item.category_id
      json.supplier_name item.supplier.name
      json.category_name item.category.name
    end
  end

  json.account_holders payment_type.account_holders
  json.account_number payment_type.account_number
  json.bank_name payment_type.bank_name
  json.payment_type_name payment_type.name
  json.order_cancel_reason_name @order.order_cancel_reason && @order.order_cancel_reason.name

  review = @order.review
  json.review do
    json.id review&.id
    json.ratings review&.ratings
    json.review review&.review
  end
end
