json.partial! 'api/components/status'
json.data do
  json.array! @orders do |order|
    json.id order.id
    json.customer_id order.customer_id
    json.order_number order.order_number
    json.total_price order.total_price
    json.ship_amount order.ship_amount
    json.payment_status order.payment_status
    json.status order.status
    json.created_at order.created_at

    json.order_items do
      json.array! order.order_items do |order_item|
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
      end
    end
  end
end

json.pager pager_meta(@pagy)
