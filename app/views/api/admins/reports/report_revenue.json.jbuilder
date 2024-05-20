json.partial! 'api/components/status'
json.data do
  json.count_order_first @calculate_order_first[:count]
  json.sum_order_first @calculate_order_first[:sum_total]
  json.sum_expense_order_first @calculate_order_first[:sum_expense]
  json.sum_income_order_first @calculate_order_first[:sum_income]

  json.count_order_second @calculate_order_second[:count]
  json.sum_order_second @calculate_order_second[:sum_total]
  json.sum_expense_order_second @calculate_order_second[:sum_expense]
  json.sum_income_order_second @calculate_order_second[:sum_income]

  json.count_order_third @calculate_order_third[:count]
  json.sum_order_third @calculate_order_third[:sum_total]
  json.sum_expense_order_third @calculate_order_third[:sum_expense]
  json.sum_income_order_third @calculate_order_third[:sum_income]
end
