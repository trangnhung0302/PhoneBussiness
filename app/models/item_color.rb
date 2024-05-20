class ItemColor < ApplicationRecord
  belongs_to :item
  has_many :order_items
  has_many :carts

  after_save :update_item_quantity

  def update_item_quantity
    total_quantity = ItemColor.where(item_id: item_id).sum(:quantity)
    item.update(quantity: total_quantity)
  end
end
