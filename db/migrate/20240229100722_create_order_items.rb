class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.references :item_color, null: true, foreign_key: true
      t.integer :quantity, null: false
      t.bigint :purchase_price, null: false
      t.bigint :price, null: false

      t.timestamps
    end
  end
end
