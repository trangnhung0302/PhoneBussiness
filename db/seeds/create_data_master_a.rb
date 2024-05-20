if Admin.count == 0
  Admin.create(
    email: 'admin@test.com',
    password: '12345678'
  )
end

if PaymentType.count == 0
  PaymentType.create(
    name: "Thanh toán tiền mặt",
  )
  PaymentType.create(
    name: "Chuyển khoản ngân hàng",
    bank_name: "MBBank",
    account_holders: "Mai Trang Nhung",
    account_number: "6660302666",
  )
end

if OrderCancelReason.count == 0
  reasons = ["Sai thông tin người nhận", "Thay đổi hình thức thanh toán", "Khác"]
  reasons.each do |reason|
    OrderCancelReason.create(
      name: reason
    )
  end
end
