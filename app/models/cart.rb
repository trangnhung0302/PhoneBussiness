class Cart < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  belongs_to :item_color, optional: true
end