json.partial! 'api/components/status'
json.data do
  json.id @item.id
  json.name @item.name
  json.supplier_id @item.supplier_id
  json.category_id @item.category_id
  json.product_no @item.product_no
  json.quantity @item.quantity
  json.purchase_price @item.purchase_price
  json.original_price @item.original_price
  json.price @item.price
  json.note @item.note
  json.status @item.status
  json.item_images do
    json.array! @item.item_images do |item_image|
      json.id item_image.id
      json.image_url item_image.image_url
    end
  end

  json.item_colors do
    json.array! @item.item_colors do |item_color|
      json.id item_color.id
      json.color item_color.color
      json.quantity item_color.quantity
      json.purchase_price item_color.purchase_price
      json.original_price item_color.original_price
      json.price item_color.price
    end
  end
end
