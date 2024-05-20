def get_provinces
  uri = URI.parse('https://online-gateway.ghn.vn/shiip/public-api/master-data/province')
  request = Net::HTTP::Get.new(uri)
  request['token'] = 'b355a4f5-e4ea-11ee-b6f7-7a81157ff3b1'

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
    http.request(request)
  end

  JSON.parse(response.body)["data"]
end

if Customer.count == 0
  @provinces = get_provinces

  ActiveRecord::Base.transaction do
    for value in 1..50 do
      customer = Customer.create(
        name: "Customer #{value}",
        email: "customer#{value}@test.com",
        phone: "0123456789",
        password: "12345678",
        status: "20",
      )

      province = nil
      while province.nil?
        province_id = rand(201..269)
        province = @provinces.find { |province| province['ProvinceID'] == province_id }
      end

      customer.customer_destinations.create(
        recipient_name: customer.name,
        recipient_phone: customer.phone,
        province_id: province_id,
        province_name: province['ProvinceName']
      )

      p "Create customer #{value} success!"
    end
  end
end
