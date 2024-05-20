json.partial! 'api/components/status'
json.data do
  json.array! @category_orders do |category_order|
    json.id category_order.id
    json.name category_order.name
    json.sum_item category_order.sum_item
    json.sum_price category_order.sum_price
    json.sum_expense category_order.sum_expense
    json.sum_income category_order.sum_income
  end
end
