json.partial! 'api/components/status'
json.data do
  json.array! @carts do |cart|
    item = cart.item
    item_color = cart.item_color

    json.id cart.id
    json.customer_id cart.customer_id
    json.item_id item.id
    json.item_name item.name
    json.color item_color && item_color.color
    json.quantity cart.quantity
    json.item_price item_color.present? ? item_color.price : item.price
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
    json.item_color_id cart.item_color_id
  end
end
