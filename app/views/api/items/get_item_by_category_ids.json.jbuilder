json.partial! 'api/components/status'
json.data do
  json.array! @items do |item|
    json.id item.id
    json.name item.name
    json.supplier_id item.supplier_id
    json.category_id item.category_id
    json.product_no item.product_no
    json.quantity item.quantity
    json.purchase_price item.purchase_price
    json.original_price item.original_price
    json.price item.price
    json.supplier_name item.supplier.name
    json.category_name item.category.name
    json.note item.note
    json.item_images do
      json.array! item.item_images do |item_image|
        json.id item_image.id
        json.image_url item_image.image_url
      end
    end
  end
end
