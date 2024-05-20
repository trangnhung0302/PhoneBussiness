if Staff.count == 0
  for value in 1..50 do
    Staff.create(
      name: "Staff #{value}",
      email: "staff#{value}@test.com",
      phone: "0123456789",
      password: "12345678",
      status: "10",
    )

    p "Create staff #{value} success!"
  end
end
