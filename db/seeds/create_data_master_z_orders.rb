if Order.count == 0
  start_date = Date.new(2022, 1, 1)
  end_date = Date.today
  date_range = (start_date..end_date).to_a

  for value in 1..3000 do
    created_at = date_range.sample
    customer_id = Customer.pluck(:id).sample
    staff_id = Staff.pluck(:id).sample
    payment_type_id = PaymentType.pluck(:id).sample
    customer_destination_id = CustomerDestination.where(customer_id: customer_id).pluck(:id).sample

    count = ItemColor.count
    random_index = rand(count)
    item_color = ItemColor.offset(random_index).first

    order = Order.create(
      customer_id: customer_id,
      payment_type_id: payment_type_id,
      customer_destination_id: customer_destination_id,
      staff_id: staff_id,
      total_price: item_color.price,
      ship_amount: rand(100) * 1000,
      status: :complete,
      payment_status: :paid,
      transport_service_id: 53322,
      transport_service_name: "Chuyển phát thương mại điện tử",
      created_at: created_at
    )
    order.order_items.create(
      item_id: item_color.item.id,
      item_color_id: item_color.id,
      quantity: 1,
      purchase_price: item_color.purchase_price,
      price: item_color.price,
      created_at: created_at
    )
    
    p "Create order #{value} success" 
  end
end
