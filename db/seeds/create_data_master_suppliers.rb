if Supplier.count == 0
  suppliers = [
    { order: 1, name: "Apple"},
    { order: 2, name: "Samsung"},
    { order: 3, name: "Xiaomi"},
    { order: 4, name: "Realme"},
    { order: 5, name: "Oppo"},
    { order: 6, name: "Vivo"},
    { order: 7, name: "LG"},
    { order: 8, name: "Dell"},
    { order: 9, name: "Macbook"},
    { order: 10, name: "HP"},
    { order: 11, name: "ASUS"},
    { order: 12, name: "Lenovo"},

  ]
  
  suppliers.each do |supplier|
    Supplier.create(
      order: supplier[:order],
      name: supplier[:name],
    )
  end

  p "Create supplier success!"
end
