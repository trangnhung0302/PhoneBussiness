if Category.count == 0
  categories = [
    { order: 1, name: "Điện thoại"},
    { order: 2, name: "Laptop"},
    { order: 3, name: "Màn hình"},
    { order: 4, name: "Máy tính bảng"},
    { order: 5, name: "Âm thanh"},
    { order: 6, name: "Đồng hồ thông minh"},
    { order: 7, name: "Tivi"},
  ]

  categories.each do |category|
    Category.create(
      order: category[:order],
      name: category[:name],
    )
  end

  p "Create categories success" 
end
