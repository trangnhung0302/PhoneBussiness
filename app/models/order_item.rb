class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item
  belongs_to :item_color, optional: true
end
