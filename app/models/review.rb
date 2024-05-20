class Review < ApplicationRecord
  belongs_to :order

  def self.find_by_item item_id
    query = self.all
    query = query.joins(:order)
    query = query.joins("left join order_items ON orders.id = order_items.order_id")
    query = query.where(order_items: {item_id: item_id})

    query = query.order(:created_at)
    query
  end
end
