json.partial! 'api/components/status'
json.data do
  json.array! @items do |item|
    json.id item.id
    json.name item.name
    json.supplier_id item.supplier_id
    json.product_no item.product_no
    json.quantity item.quantity
    json.purchase_price item.purchase_price
    json.original_price item.original_price
    json.price item.price
    json.note item.note
    json.supplier_name item.supplier.name
    json.category_name item.category.name
  end
end

json.pager pager_meta(@pagy)
