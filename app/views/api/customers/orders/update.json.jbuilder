json.partial! 'api/components/status'
json.data do
  payment_type = @order.payment_type
  json.id @order.id
  json.order_number @order.order_number
  json.total_price @order.total_price
  json.ship_amount @order.ship_amount
  json.account_holders payment_type.account_holders
  json.account_number payment_type.account_number
  json.bank_name payment_type.bank_name
  json.payment_status @order.payment_status
end
